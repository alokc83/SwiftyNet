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
    
    public init(status: String, data: T?, message: String?) {
        self.status = status
        self.data = data
        self.message = message
    }
}
