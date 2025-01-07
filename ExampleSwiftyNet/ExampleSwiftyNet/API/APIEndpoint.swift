import Foundation
import SwiftyNet

enum APIEndpoint {
    case products(limit: Int? = nil)
    case users(id: Int? = nil)
    
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
        }
    }
    
    private static let baseURL = URL(string: "https://fakestoreapi.com")!
} 