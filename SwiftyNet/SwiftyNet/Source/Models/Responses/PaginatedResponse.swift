//
//  PaginatedResponse.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

public struct PaginatedResponse<T: Decodable>: Decodable {
    public let data: [T]
    public let nextPage: String?
    
    public init(data: [T], nextPage: String?) {
        self.data = data
        self.nextPage = nextPage
    }
}
