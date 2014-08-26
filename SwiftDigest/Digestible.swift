//
//  Digestible.swift
//  SwiftDigest
//
//  Created by Brent Royal-Gordon on 8/25/14.
//  Copyright (c) 2014 Groundbreaking Software. All rights reserved.
//

import Foundation

/// Types conform to the Digestible protocol to indicate that they can be part of 
/// a digest.
public protocol Digestible {
    func withDigestibleData(append: UnsafeBufferPointer<UInt8> -> Void)
}

extension NSData: Digestible {
    /// NSData objects can be added to a digest. The digest will include the bytes in 
    /// the NSData object.
    public func withDigestibleData(append: UnsafeBufferPointer<UInt8> -> Void) {
        append(self.bufferPointer)
    }
}

extension String: Digestible {
    /// String instances can be added to a digest. The digest will include the UTF-8 
    /// bytes of the string with no canonicalization. If you want different behavior, 
    /// convert the String to an array of bytes and add it yourself.
    public func withDigestibleData(append: UnsafeBufferPointer<UInt8> -> Void) {
        Array(utf8).withUnsafeBufferPointer(append)
    }
}

extension UInt8: Digestible {
    /// UInt8 instances can be added to a digest. The digest will include a byte with
    /// the same bit pattern as the UInt8. Other Int types are not Digestible because 
    /// their representation may vary between different machines.
    public func withDigestibleData(append: UnsafeBufferPointer<UInt8> -> Void) {
        [ self ].withUnsafeBufferPointer(append)
    }
}

internal struct DigestibleArray: Digestible {
    var array: [UInt8]
    internal func withDigestibleData(append: UnsafeBufferPointer<UInt8> -> Void) {
        array.withUnsafeBufferPointer(append)
    }
}