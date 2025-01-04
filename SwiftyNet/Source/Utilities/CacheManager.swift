//
//  CacheManager.swift
//  SwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

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

