//
//  SHA1Tests.swift
//  SwiftDigest
//
//  Created by Brent Royal-Gordon on 8/26/14.
//  Copyright (c) 2014 Groundbreaking Software. All rights reserved.
//

import Cocoa
import XCTest
import SwiftDigest

class SHA1Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDigest() {
        XCTAssertEqual(digest("abc", algorithm: SHA1()).hex, "a9993e364706816aba3e25717850c26c9cd0d89d", "Basic SHA1 test vector correct")
    }

    func testDigestBufferCopying() {
        var buffer = DigestBuffer(SHA256())
        buffer += "a"
        buffer += "b"
        
        var copy = buffer
        copy += "c"
        XCTAssertEqual(copy.digest.hex, "a9993e364706816aba3e25717850c26c9cd0d89d", "Copy correct")

        buffer += "c"
        XCTAssertEqual(buffer.digest.hex, "a9993e364706816aba3e25717850c26c9cd0d89d", "Original not affected by copy")
    }
}
