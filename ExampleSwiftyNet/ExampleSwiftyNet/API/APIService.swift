//
//  APIService.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/5/25.
//

import Foundation
import SwiftyNet

class APIService {
    private let httpClient: HTTPClientProtocol

    init(httpClient: HTTPClientProtocol = HTTPClient(
        cacheManager: CacheManager(),
        networkMonitor: NetworkMonitor()
    )) {
        self.httpClient = httpClient
    }

    func fetchProducts() async throws -> [Product] {
        let endpoint = Endpoint(
            baseURL: URL(string: "https://fakestoreapi.com")!,
            path: "/products",
            method: .get
        )
        return try await httpClient.sendRequest(endpoint, responseType: [Product].self)
    }

    func fetchUsers() async throws -> [User] {
        let endpoint = Endpoint(
            baseURL: URL(string: "https://fakestoreapi.com")!,
            path: "/users",
            method: .get
        )
        return try await httpClient.sendRequest(endpoint, responseType: [User].self)
    }
}
