//
//  SHA256.swift
//  SwiftDigest
//
//  Created by Brent Royal-Gordon on 8/25/14.
//  Copyright (c) 2014 Groundbreaking Software. All rights reserved.
//

import Foundation

/// The SHA256 class implements the NSA's SHA-256 algorithm, standardized as
/// FIPS PUB 180-4, using CommonCrypto. 
public struct SHA256: AlgorithmType {
    private var context: CC_SHA256_CTX
    
    /// SHA256 should be initialized without any parameters.
    public init() {
        context = CC_SHA256_CTX.make()
    }
    
    public mutating func append(data: UnsafeBufferPointer<UInt8>) {
        CC_SHA256_Update(&context, UnsafePointer<Void>(data.baseAddress), CC_LONG(data.count))
    }
    
    public mutating func finish() -> [UInt8] {
        var data: [UInt8] = Array(count: Int(CC_SHA256_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA256_Final(&data, &context)
        
        return data
    }
}

extension CC_SHA256_CTX {
    static func make() -> CC_SHA256_CTX {
        let ptr = UnsafeMutablePointer<CC_SHA256_CTX>.alloc(1)
        CC_SHA256_Init(ptr)
        return ptr.memory
    }
}
