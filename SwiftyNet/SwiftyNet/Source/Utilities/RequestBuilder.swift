//
//  RequestBuilder.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

public struct RequestBuilder {
    public static func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        var url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        // Add query items
        if let queryItems = endpoint.queryItems {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            guard let updatedURL = components?.url else {
                throw APIError.invalidURL
            }
            url = updatedURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        endpoint.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
}
