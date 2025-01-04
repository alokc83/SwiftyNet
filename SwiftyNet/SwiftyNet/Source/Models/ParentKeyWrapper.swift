//
//  ParentKeyWrapper.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

/// Wrapper to decode a specific key from JSON
public struct ParentKeyWrapper<T: Decodable>: Decodable {
    public let data: T
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}
