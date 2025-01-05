//
//  CacheManager.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

// Add this protocol definition at the top of the file
public protocol CacheManaging {
    func save(data: Data, forKey key: String)
    func retrieve(forKey key: String) -> Data?
    func clear()
    func remove(forKey key: String)
}

public final class CacheManager {
    private let cache = NSCache<NSString, NSData>()
    
    public init() {}
    
    public func save(data: Data, forKey key: String) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    public func retrieve(forKey key: String) -> Data? {
        return cache.object(forKey: key as NSString) as Data?
    }
    
    public func clear() {
        cache.removeAllObjects()
    }
}

