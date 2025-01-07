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

    func fetchProducts(limit: Int? = nil) async throws -> [Product] {
        try await httpClient.sendRequest(APIEndpoint.products(limit: limit).endpoint, responseType: [Product].self)
    }

    func fetchUsers(id: Int? = nil) async throws -> [User] {
        try await httpClient.sendRequest(APIEndpoint.users(id: id).endpoint, responseType: [User].self)
    }
}
