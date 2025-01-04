//
//  JSONDecoder.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

public extension JSONDecoder {
    /// Returns a JSONDecoder with custom configurations.
    static func customDecoder(
        dateDecodingStrategy: DateDecodingStrategy = .iso8601,
        keyDecodingStrategy: KeyDecodingStrategy = .useDefaultKeys
    ) -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        return decoder
    }
}
