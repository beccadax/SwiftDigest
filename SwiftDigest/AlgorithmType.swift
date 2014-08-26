//
//  AlgorithmType.swift
//  SwiftDigest
//
//  Created by Brent Royal-Gordon on 8/25/14.
//  Copyright (c) 2014 Groundbreaking Software. All rights reserved.
//

import Foundation

/// The AlgorithmType protocol represents a digest algorithm. Each
/// AlgorithmType instance represents one in-progress digest. You can 
/// work with an AlgorithmType directly if you need the absolute best 
/// performance, but you should usually use it with a DigestBuffer 
/// instance or the digest(_:algorithm:) function.
/// 
/// AlgorithmTypes must implement value semantics; otherwise 
/// you will not be able to copy any DigestBuffer using that algorithm, 
/// or continue using a DigestBuffer after reading a Digest from them.
public protocol AlgorithmType {
    /// Adds data to the algorithm object's internal state.
    mutating func append(data: UnsafeBufferPointer<UInt8>)
    
    /// Returns the completed digest. You should not call any other 
    /// methods on the instance after calling finish().
    mutating func finish() -> [UInt8]
}
