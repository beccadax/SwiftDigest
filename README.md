SwiftDigest
========

SwiftDigest is a library for cleanly and correctly calculating digests or hashes of 
data. It is designed to be simple to use for simple tasks, but well-factored and 
cleanly designed enough for complex tasks, and extensible with new algorithms and 
features. It is not designed to implement algorithms in pure Swift, although you 
could certainly do that yourself.

SwiftDigest currently supports only SHA-256, using CommonCrypto as its engine.
Additional algorithms can be added from your own code. I'm also happy to accept
pull requests.

Synopsis
------

    // Simple, "all at once" interface
    digest(myString, algorithm: SHA256()).hex
    
    // Or build it up over time
    var buffer = DigestBuffer(SHA256())
    // Periodically:
    buffer += someData
    // When you want a digest from it:
    let digest = buffer.digest
    
    // The digest is available in multiple formats:
    digest.bytes
    digest.data
    digest.hex
    digest.base64WithOptions(nil)

Algorithms and `AlgorithmType`
-----------------------

To calculate a digest with SwiftDigest, you will first have to instantiate an 
algorithm. Algorithms conform to the `AlgorithmType` protocol and present a 
very simple, fairly useless interface. You usually won't use one directly; 
instead, you'll pass it to another part of SwiftDigest with a friendlier 
interface. However, if you need the absolute best speed possible, you can 
use a raw algorithm.

`AlgorithmType` does not specify any constructors, and construction is up to 
the individual conforming types. Currently, the only algorithm included in 
SwiftDigest is `SHA256`, but you can create your own alogorithms. See the 
documentation comments on `AlgorithmType` for details on what you need to 
do.

The `digest()` Functions
------------------

SwiftDigest provides a `digest(_: algorithm:)` function as a simple interface 
to its functionality. The first parameter is the data, which can be in one of four 
formats:

* A `[UInt8]` array of bytes.
* An instance conforming to `Digestible`. `Digestible` types know how to feed 
  themselves into an Algorithm. They include `String`, `NSData`, and `UInt8`.
* A `SequenceType` of `[UInt8]` arrays of bytes. (Currently disabled due to 
  compiler trouble.)
* A `SequenceType` of `Digestible` instances.

Instances in the `Sequence` variants mentioned above will be added to the digest 
one at a time, so `digest()` plays quite well with Swift's built-in `lazy()` 
sequences.

`digest()` returns a `Digest` object, described below. Internally, it uses a 
`DigestBuffer`.

The `Digest` Class
--------------

A completed digest is available as a `Digest` object. Each `Digest` object 
contains an immutable digest value, which it can format in many ways:

* `bytes`: a `[UInt8]` array of raw bytes.
* `data`: an `NSData` object containing the raw bytes.
* `hex`: a `String` containing a hexadecimal representation of the digest.
* `base64WithOptions()`: returns a Base64-encoded `String`. Options are as 
  in Foundation.
* `base64DataWithOptions()`: returns a Base64-encoded `NSData`. Options
  are as in Foundation.
* `base64BytesWithOptions()` returns a Base64-encoded `[UInt8]` byte array.
  Options are as in Foundation.

`Digest`s are also Equatable, Hashable, and Comparable. Shorter digests are 
treated as less than longer digests, but you should only ever encounter this 
case if you're comparing digests from different algorithms.

The `DigestBuffer` Type
-----------------

A `DigestBuffer` allows you to incrementally build up a digest, optionally 
reading values out of it as you go along. To get started, allocate a 
`DigestBuffer` with a new algorithm:

    var buffer = DigestBuffer(SHA256())

Then append some data. The `append()` method comes in several variants, 
taking a `Digestible` object, a `[UInt8]` array, or an `UnsafeArrayBuffer`
of `UInt8`s.

    buffer.append(data)
    buffer.append(moreData)

You can also use the overloaded `+=` operator, or the `+` operator, which 
goes well with `reduce()`.

    buffer += data
    buffer += moreData

At any time, you can get a `Digest` object from the `digest` property and 
use it:

    let digest = buffer.digest

But even after doing so, it's okay to keep modifying the buffer; the old 
digest object won't be affected:

    buffer += evenMoreData

Copying a `DigestBuffer` will also give you an independent instance 
containing all the in-progress data that the old digest had:

    var otherBuffer = buffer
    buffer += "c"
    otherBuffer += "c"
    buffer.digest == otherBuffer.digest

Contributing
---------

Contributions are welcome, and should be submitted as pull requests to 
[GitHub](https://github.com/brentdax/SwiftDigest). If you want to contribute 
an algorithm, please observe the following rules:

* Include at least two tests: one ensuring that basic hashing works, and one 
  ensuring you can correctly copy a `DigestBuffer` configured with your 
  algorithm. The current tests include examples of these tests for `SHA256`.
* The main SwiftDigest repository is for production-ready implementations of 
  algorithms. Pure Swift reimplementations of algorithms will only be accepted 
  if they're written by experienced cryptographic engineers. You should instead 
  rely on a well-tested cryptographic library like CommonCrypto.

Author
-----

Brent Royal-Gordon <brent@architechies.com> for Groundbreaking Software.

Please drop me a line if you use SwiftDigest in a product. I'd love to see where 
it goes and find out what could be improved.

Copyright
-------

Copyright (C) 2014 Groundbreaking Software LLC. Distributed under the MIT 
License.

> Permission is hereby granted, free of charge, to any person obtaining a copy 
> of this software and associated documentation files (the "Software"), to deal 
> in the Software without restriction, including without limitation the rights to 
> use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
> of the Software, and to permit persons to whom the Software is furnished to do 
> so, subject to the following conditions:
> 
> The above copyright notice and this permission notice shall be included in all 
> copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
> OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
> FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
> IN THE SOFTWARE.


