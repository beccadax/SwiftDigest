//
//  DigestBuffer.swift
//  SwiftDigest
//
//  Created by Brent Royal-Gordon on 8/25/14.
//  Copyright (c) 2014 Groundbreaking Software. All rights reserved.
//

import Foundation

/// A DigestBuffer represents an in-progress digest. You can append data in 
/// various forms to the DigestBuffer and use its ``digest`` property to fetch a 
/// completed Digest instance at any point in the process.
public struct DigestBuffer<Algorithm: AlgorithmType> {
    private var algorithm: Algorithm
    
    /// Creates a new DigestBuffer that feeds into the indicated Algorithm.
    public init(_ algorithm: Algorithm) {
        self.algorithm = algorithm
    }
    
    /// Adds the bytes in the byteBuffer to the digest.
    public mutating func append(byteBuffer: UnsafeBufferPointer<UInt8>) {
        algorithm.append(byteBuffer)
    }
    
    /// Adds the bytes in the Digestible instance to the digest.
    public mutating func append(digestibleData: Digestible) {
        digestibleData.withDigestibleData(append)
    }
    
    /// Adds the bytes in the byte array to the digest.
    public mutating func append(bytes: [UInt8]) {
        append(DigestibleArray(array: bytes))
    }
    
    /// Retrieves the digest of all data appended to the DigestBuffer so far.
    public var digest: Digest {
        return Digest(algorithm: algorithm)
    }
}

extension DigestBuffer: SinkType {
    public mutating func put(var element: UInt8) {
        self.append(element)
    }
}

/// Shorthand for calling append() on the DigestBuffer.
public func += <Algorithm: AlgorithmType>(inout digestBuffer: DigestBuffer<Algorithm>, digestible: Digestible) {
    digestBuffer.append(digestible)
}

/// Shorthand for calling append() on the DigestBuffer.
public func += <Algorithm: AlgorithmType>(inout digestBuffer: DigestBuffer<Algorithm>, bytes: [UInt8]) {
    digestBuffer.append(bytes)
}

/// Shorthand for calling append() on a copy of the DigestBuffer.
public func + <Algorithm: AlgorithmType>(var digestBuffer: DigestBuffer<Algorithm>, digestible: Digestible) -> DigestBuffer<Algorithm> {
    digestBuffer.append(digestible)
    return digestBuffer
}

/// Shorthand for calling append() on a copy of the DigestBuffer.
public func + <Algorithm: AlgorithmType>(var digest: DigestBuffer<Algorithm>, bytes: [UInt8]) -> DigestBuffer<Algorithm> {
    digest.append(bytes)
    return digest
}
