//
//  RequestBuilder.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

public protocol RequestBuildable {
    static func buildRequest(from endpoint: EndpointProtocol) throws -> URLRequest
}

public struct RequestBuilder: RequestBuildable {
    public static func buildRequest(from endpoint: EndpointProtocol) throws -> URLRequest {
        var url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        if let queryItems = endpoint.queryItems {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            
            guard let updatedURL = components?.url else {
                throw APIError.invalidURL
            }
            url = updatedURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = 30
        
        // Add default headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Add custom headers
        endpoint.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        return request
    }
}
