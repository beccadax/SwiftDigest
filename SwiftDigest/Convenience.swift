//
//  Convenience.swift
//  SwiftDigest
//
//  Created by Brent Royal-Gordon on 8/26/14.
//  Copyright (c) 2014 Groundbreaking Software. All rights reserved.
//

import Foundation

/// Generates a digest from a piece of data in one step. This is the simplest way 
/// to calculate a digest with SwiftDigest. There are several variants which take 
/// different data types.
/// 
/// :param: data A Digestible instance containing the data to be digested.
///
/// :param: algorithm An AlgorithmType instance representing the digest 
///                      algorithm to use.
/// 
/// :returns: A Digest object, from which you can fetch the digest in various forms.
public func digest<Algorithm: AlgorithmType>(data: Digestible, #algorithm: Algorithm) -> Digest {
    var buffer = DigestBuffer(algorithm)
    buffer.append(data)
    return buffer.digest
}

/// Generates a digest from a piece of data in one step. This is the simplest way 
/// to calculate a digest with SwiftDigest. There are several variants which take 
/// different data types.
/// 
/// :param: data An array of bytes, represented as UInt8 instances.
///
/// :param: algorithm An AlgorithmType instance representing the digest 
///                      algorithm to use.
/// 
/// :returns: A Digest object, from which you can fetch the digest in various forms.
public func digest<Algorithm: AlgorithmType>(data: [UInt8], #algorithm: Algorithm) -> Digest {
    var buffer = DigestBuffer(algorithm)
    buffer.append(data)
    return buffer.digest
}

/// Generates a digest from a piece of data in one step. This is the simplest way 
/// to calculate a digest with SwiftDigest. There are several variants which take 
/// different data types.
/// 
/// :param: data A Sequence of Digestible instances. The instances in lazy
///                 Sequences will be appended one at a time.
///
/// :param: algorithm An AlgorithmType instance representing the digest 
///                      algorithm to use.
/// 
/// :returns: A Digest object, from which you can fetch the digest in various forms.
public func digest<Algorithm: AlgorithmType, S: SequenceType where S.Generator.Element == Digestible>(dataSeq: S, #algorithm: Algorithm) -> Digest {
    return reduce(dataSeq, DigestBuffer(algorithm), +).digest
}

// XXX Disabled due to compiler crash in Beta 6
/// Generates a digest from a piece of data in one step. This is the simplest way 
/// to calculate a digest with SwiftDigest. There are several variants which take 
/// different data types.
/// 
/// :param: data A Sequence of Arrays of bytes, represented as UInt8 instances.
///                 The instances in lazy Sequences will be appended one at a time.
///
/// :param: algorithm An AlgorithmType instance representing the digest 
///                      algorithm to use.
/// 
/// :returns: A Digest object, from which you can fetch the digest in various forms.
//public func digest<Algorithm: AlgorithmType, S: SequenceType where S.Generator.Element == Array<UInt8>>(dataSeq: S, #algorithm: Algorithm) -> Digest {
//    return reduce(dataSeq, DigestBuffer(algorithm), +).digest
//}
