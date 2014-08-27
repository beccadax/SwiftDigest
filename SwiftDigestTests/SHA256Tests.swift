//
//  SHA256Tests.swift
//  SwiftDigest
//
//  Created by Brent Royal-Gordon on 8/26/14.
//  Copyright (c) 2014 Groundbreaking Software. All rights reserved.
//

import Cocoa
import XCTest
import SwiftDigest

class SHA256Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDigest() {
        XCTAssertEqual(digest("abc", algorithm: SHA256()).hex, "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad", "Basic SHA256 test vector correct")
    }
    
    func testDigestBufferCopying() {
        var buffer = DigestBuffer(SHA256())
        buffer += "a"
        buffer += "b"
        
        var copy = buffer
        copy += "c"
        XCTAssertEqual(copy.digest.hex, "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad", "Copy correct")

        buffer += "c"
        XCTAssertEqual(buffer.digest.hex, "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad", "Original not affected by copy")
    }
    
}

