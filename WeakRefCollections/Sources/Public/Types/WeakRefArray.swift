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
        self._array = s.map({ WeakWrapper_($0) })
    }
    
    public init(repeating repeatedValue: Element, count: Int) {
        self._array = Array(repeating: WeakWrapper_(repeatedValue), count: count)
    }
    
    // ExpressibleByArrayLiteral Implementation
    required public init(arrayLiteral elements: Element...) {
        self._array = elements.map({ WeakWrapper_($0) })
    }
    
    // Private Variable Properties
    fileprivate var _array: [WeakWrapper_]
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
    func valueDeinitialized(of weakWrapper: WeakWrapper_) {
        self._numberOfEmptyWrappers += 1
    }
}


// MARK: // Private
// MARK: Array Interface Implementations

// MARK: Purging / Extracting
private extension WeakRefArray {
    @discardableResult func _purge(forEachExistingElement: ((Element) -> Void)? = nil) {
        var purgedArray: [WeakWrapper_] = []
        let rawArray: [WeakWrapper_] = self._array
        
        for wrapper in rawArray {
            if let value: Element = wrapper.value as? Element {
                purgedArray.append(wrapper)
                forEachExistingElement?(value)
            }
        }
        
        self._array = purgedArray
        self._numberOfEmptyWrappers = 0
    }
    
    func _extract() -> [Element] {
        var extractedArray: [Element] = []
        self._purge(forEachExistingElement: {
            extractedArray.append($0)
        })
        return extractedArray
    }
}

