//
//  SwiftDigest.h
//  SwiftDigest
//
//  Created by Brent Royal-Gordon on 8/25/14.
//  Copyright (c) 2014 Groundbreaking Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for SwiftDigest.
FOUNDATION_EXPORT double SwiftDigestVersionNumber;

//! Project version string for SwiftDigest.
FOUNDATION_EXPORT const unsigned char SwiftDigestVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SwiftDigest/PublicHeader.h>

// We use CommonDigest, and unfortunately, Swift modules use the umbrella header as the bridging header. This sucks.
#import <CommonCrypto/CommonDigest.h>
