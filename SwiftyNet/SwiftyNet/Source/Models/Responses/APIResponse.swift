//
//  APIResponse.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

public struct APIResponse<T: Decodable>: Decodable {
    public let status: String
    public let data: T?
    public let message: String?
    public let error: String?
    
    public init(
        status: String,
        data: T? = nil,
        message: String? = nil,
        error: String? = nil
    ) {
        self.status = status
        self.data = data
        self.message = message
        self.error = error
    }
}
