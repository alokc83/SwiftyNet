//
//  PaginatedResponse.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

public protocol Paginatable {
    associatedtype Item: Decodable
    var data: [Item] { get }
    var nextPage: String? { get }
    var totalPages: Int? { get }
    var totalItems: Int? { get }
}

public struct PaginatedResponse<T: Decodable>: Decodable, Paginatable {
    public let data: [T]
    public let nextPage: String?
    public let totalPages: Int?
    public let totalItems: Int?
    
    public init(
        data: [T],
        nextPage: String? = nil,
        totalPages: Int? = nil,
        totalItems: Int? = nil
    ) {
        self.data = data
        self.nextPage = nextPage
        self.totalPages = totalPages
        self.totalItems = totalItems
    }
}
