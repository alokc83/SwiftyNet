//
//  HTTPClient.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

public final class HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func sendRequest<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T {
        var url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        // Add query items to URL
        if let queryItems = endpoint.queryItems {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            if let updatedURL = components?.url {
                url = updatedURL
            }
        }
        
        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        endpoint.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        // Perform request
        let (data, response) = try await session.data(for: request)
        
        // Validate response
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw APIError.requestFailed(
                statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1,
                data: data
            )
        }
        
        // Decode response
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
