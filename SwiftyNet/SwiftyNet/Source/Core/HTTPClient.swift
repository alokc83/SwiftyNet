//
//  HTTPClient.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

public protocol HTTPClientProtocol {
    func sendRequest<T: Decodable>(_ endpoint: EndpointProtocol, responseType: T.Type) async throws -> T
}

public final class HTTPClient: HTTPClientProtocol {
    private let session: URLSession
    private let cacheManager: CacheManaging
    private let networkMonitor: NetworkMonitoring
    private let errorHandler: ErrorHandling
    
    public init(
        session: URLSession = .shared,
        cacheManager: CacheManaging,
        networkMonitor: NetworkMonitoring,
        errorHandler: ErrorHandling = ErrorHandler()
    ) {
        self.session = session
        self.cacheManager = cacheManager
        self.networkMonitor = networkMonitor
        self.errorHandler = errorHandler
    }
    
    public func sendRequest<T: Decodable>(_ endpoint: EndpointProtocol, responseType: T.Type) async throws -> T {
        guard networkMonitor.isConnected else {
            throw APIError.networkUnavailable
        }
        
        let request = try RequestBuilder.buildRequest(from: endpoint)
        let cacheKey = endpoint.path
        
        if endpoint.method == .get,
           let cachedData = cacheManager.retrieve(forKey: cacheKey),
           let cachedResponse = try? DecodingHelper.decode(responseType, from: cachedData) {
            return cachedResponse
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            try validateResponse(response)
            
            let decodedResponse = try DecodingHelper.decode(responseType, from: data)
            
            if endpoint.method == .get {
                cacheManager.save(data: data, forKey: cacheKey)
            }
            
            return decodedResponse
        } catch {
            throw errorHandler.map(error)
        }
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return
        case 401:
            throw APIError.unauthorized
        default:
            throw APIError.requestFailed(statusCode: httpResponse.statusCode, data: nil)
        }
    }
}
