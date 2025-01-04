//
//  ErrorHandler.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

public struct ErrorHandler {
    public static func userFriendlyMessage(from error: APIError) -> String {
        switch error {
        case .invalidURL:
            return "There was an issue with the URL. Please try again."
        case .requestFailed(_, _):
            return "The server responded with an error. Please try again later."
        case .decodingError:
            return "We encountered an issue while processing the response."
        case .networkUnavailable:
            return "No internet connection. Please check your network settings."
        case .unknown:
            return "An unexpected error occurred. Please try again."
        }
    }
}


