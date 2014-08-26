//
//  Extensions.swift
//  SwiftDigest
//
//  Created by Brent Royal-Gordon on 8/25/14.
//  Copyright (c) 2014 Groundbreaking Software. All rights reserved.
//

import Foundation

internal extension NSData {
    var bufferPointer: UnsafeBufferPointer<UInt8> {
        return UnsafeBufferPointer<UInt8>(start: UnsafePointer(self.bytes), count: self.length)
    }
}

internal extension UInt8 {
    private static let allHexits: [Character] = Array("0123456789abcdef")
    
    func toHex() -> String {
        let nybbles = [ self >> 4, self & 0x0F ]
        let hexits = map(nybbles) { nybble in UInt8.allHexits[Int(nybble)] }
        return String(seq: hexits)
    }
}
