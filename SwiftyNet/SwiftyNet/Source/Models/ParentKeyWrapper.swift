//
//  ParentKeyWrapper.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

public protocol Wrappable {
    associatedtype WrappedType: Decodable
    var data: WrappedType { get }
}

public struct ParentKeyWrapper<T: Decodable>: Decodable, Wrappable {
    public let data: T
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}
