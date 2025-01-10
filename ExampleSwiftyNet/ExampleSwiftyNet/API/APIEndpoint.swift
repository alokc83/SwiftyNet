//
//  APIEndpoint.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/5/25.
//

import Foundation
import SwiftyNet

enum APIEndpoint {
    case products(limit: Int? = nil)
    case users(id: Int? = nil)
    case categories
    case productsByCategory(category: String)
    
    var endpoint: Endpoint {
        switch self {
        case .products(let limit):
            var queryItems: [URLQueryItem]? = nil
            if let limit {
                queryItems = [URLQueryItem(name: "limit", value: "\(limit)")]
            }
            return Endpoint(
                baseURL: Self.baseURL,
                path: "/products",
                method: .get,
                queryItems: queryItems
            )
            
        case .users(let id):
            let path = id.map { "/users/\($0)" } ?? "/users"
            return Endpoint(
                baseURL: Self.baseURL,
                path: path,
                method: .get
            )
            
        case .categories:
            return Endpoint(
                baseURL: Self.baseURL,
                path: "/products/categories",
                method: .get
            )
            
        case .productsByCategory(let category):
            return Endpoint(
                baseURL: Self.baseURL,
                path: "/products/category/\(category)",
                method: .get
            )
        }
    }
    
    private static let baseURL = URL(string: "https://fakestoreapi.com")!
} 