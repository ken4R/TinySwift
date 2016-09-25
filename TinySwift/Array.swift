//
//  Array.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public extension Array {
    /// Returns a randomized array's element.
    public var random: Element? {
        guard !isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    
    /**
     Accesses the element at the specified position in a safe way.
     
     **Use the setter carefully**: When getter is 100% safe, setter does nothing if you try to set `nil` as a new value. You should use `Optional<T>(nilLiteral: ())` (where `T` is an array's element type) instead of `nil` or do not use it at all.
     
     The prohibited usage stops program execution in a debuggable state after printing message in playgrounds and `-Onone` builds.
     
     It cannot be fixed until Swift support for a generic subscripts. Read more [here](https://bugs.swift.org/browse/SR-115).
     
     - parameter index: The position of the element to access. `index` **must not** be greater than or equal to `startIndex` and less than `endIndex`, because elements are accessed in a safe way.
     */
    public subscript(safe index: Int) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            assert(newValue != nil, "Do not set nil as a new value through array's safe: subscript. You should use Optional<T>(nilLiteral: ()) (where T is an array's element type) instead of nil or do not use it at all. Read the documentation for more informations.")
            guard let newValue = newValue, indices.contains(index) else { return }
            self[index] = newValue
        }
    }
}

public extension Array where Element: Equatable {
    /// A Boolean value that determines whether all elements of the array are equal.
    public var areAllElementsEqual: Bool {
        guard let first = first else { return true }
        return !dropFirst().contains { $0 != first }
    }
}
