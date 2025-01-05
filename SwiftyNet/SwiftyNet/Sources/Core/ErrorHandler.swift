//
//  ErrorHandler.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

public protocol ErrorHandling {
    func handle(_ error: APIError) -> String
    func map(_ error: Error) -> APIError
}

public struct ErrorHandler: ErrorHandling {
    public init() {}
    
    public func handle(_ error: APIError) -> String {
        switch error {
        case .invalidURL:
            return "There was an issue with the URL. Please try again."
        case .requestFailed(_, _):
            return "The server responded with an error. Please try again later."
        case .decodingError:
            return "We encountered an issue while processing the response."
        case .networkUnavailable:
            return "No internet connection. Please check your network settings."
        case .invalidResponse:
            return "We received an invalid response. Please try again."
        case .timeout:
            return "The request timed out. Please try again."
        case .unauthorized:
            return "Please log in to continue."
        case .unknown:
            return "An unexpected error occurred. Please try again."
        }
    }
    
    public func map(_ error: Error) -> APIError {
        switch error {
        case is DecodingError:
            return .decodingError(error)
        case let apiError as APIError:
            return apiError
        case let urlError as URLError:
            switch urlError.code {
            case .timedOut:
                return .timeout
            case .notConnectedToInternet:
                return .networkUnavailable
            default:
                return .unknown(error)
            }
        default:
            return .unknown(error)
        }
    }
}
