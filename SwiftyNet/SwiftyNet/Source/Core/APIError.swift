//
//  APIError.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case requestFailed(statusCode: Int, data: Data?)
    case decodingError(Error)
    case networkUnavailable
    case unknown(Error)
    
    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .requestFailed(let statusCode, _):
            return "Request failed with status code \(statusCode)."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .networkUnavailable:
            return "The network is unavailable."
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
