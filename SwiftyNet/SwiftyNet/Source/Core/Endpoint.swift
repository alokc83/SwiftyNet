//
//  Endpoint.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

public struct Endpoint {
    public let baseURL: URL
    public let path: String
    public let method: String
    public let queryItems: [URLQueryItem]?
    public let headers: [String: String]?
    
    public init(baseURL: URL, path: String, method: String = "GET", queryItems: [URLQueryItem]? = nil, headers: [String: String]? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
    }
}
