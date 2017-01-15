//
//  WeakRefArray.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 12/17/16.
//  Copyright © 2016 JanNash. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Array Interface
public extension WeakRefArray {
    
}


// MARK: Class Declaration
public class WeakRefArray<Element: AnyObject> {
    // Array Inits
    public init() {
        self._array = []
    }
    
    public init<S : Sequence>(_ s: S) where S.Iterator.Element == Element {
        var array: [WeakWrapper_] = []
        var previous: WeakWrapper_? = nil
        for value in s {
            let wrapper: WeakWrapper_ = WeakWrapper_(value: value, previous: previous, delegate: self)
            array.append(wrapper)
            previous = wrapper
        }
        
        self._array = array
    }
    
    // ExpressibleByArrayLiteral Implementation
    required public init(arrayLiteral elements: Element...) {
        self._array.reserveCapacity(elements.count)
        var previous: WeakWrapper_? = nil
        for value in elements {
            let wrapper: WeakWrapper_ = WeakWrapper_(value: value, previous: previous, delegate: self)
            self._array.append(wrapper)
            previous = wrapper
        }
    }
    
    // Private Init Helper Function
    private func wrapMap(_ previous: inout WeakWrapper_?) -> ((Element) -> WeakWrapper_) {
        var _previous: WeakWrapper_? = previous
        return {
            value in
            let wrapper: WeakWrapper_ = WeakWrapper_(value: value, previous: _previous, delegate: nil)
            _previous = wrapper
            return wrapper
        }
    }
    
    // Private Variable Properties
    fileprivate var _array: [WeakWrapper_] = []
    fileprivate var _numberOfEmptyWrappers: Int = 0
}


// MARK: ExpressibleByArrayLiteral
// (Implementation in class declaration)
extension WeakRefArray: ExpressibleByArrayLiteral {}


// MARK: CustomStringConvertible
extension WeakRefArray: CustomStringConvertible {
    public var description: String {
        return "WeakRefArray" + self._array.debugDescription
    }
}


// MARK: CustomDebugStringConvertible
extension WeakRefArray: CustomDebugStringConvertible {
    public var debugDescription: String {
        let array: [WeakWrapper_] = self._array
        let count: Int = array.count
        let purgedCount: Int = count - self._numberOfEmptyWrappers
        let arrayDescription: String = array.debugDescription
        return "WeakRefArray(" +
            "count: \(count), " +
            "purgedCount: \(purgedCount), " +
            "array: \(arrayDescription)" +
        ")"
    }
}


// MARK: WeakWrapperDelegate
extension WeakRefArray: WeakWrapperDelegate_ {
    func didDisconnect(weakWrapper: WeakWrapper_) {
        self._array.remove(at: weakWrapper.index)
    }
}
