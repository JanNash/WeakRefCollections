//
//  WeakRefArray.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 12/17/16.
//  Copyright © 2016 JanNash. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Class Declaration
public class WeakRefArray<Element: AnyObject> {
    // Inits
    public init() {
        self._array = []
    }
    
    public init<S : Sequence>(_ s: S) where S.Iterator.Element == Element {
        self._array = s.map({ WeakWrapper_($0) })
    }
    
    public init(repeating repeatedValue: Element, count: Int) {
        self._array = Array(repeating: WeakWrapper_(repeatedValue), count: count)
    }
    
    // ExpressibleByArrayLiteral
    required public init(arrayLiteral elements: Element...) {
        self._array = elements.map({ WeakWrapper_($0) })
    }
    
    // Private Variable Properties
    fileprivate var _array: Array<WeakWrapper_<Element>>
}


// MARK: ExpressibleByArrayLiteral
extension WeakRefArray: ExpressibleByArrayLiteral {
    
}
