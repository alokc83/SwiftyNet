//
//  URLRequest+extension.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

public extension URLRequest {
    mutating func setJSONContentType() {
        setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    mutating func setAuthorizationHeader(token: String) {
        setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    
    mutating func setTimeout(_ timeout: TimeInterval) {
        timeoutInterval = timeout
    }
}
