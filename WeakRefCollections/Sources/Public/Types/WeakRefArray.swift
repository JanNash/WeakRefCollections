//
//  WeakRefArray.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 12/17/16.
//  Copyright © 2016 JanNash. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: SelfPurgingType
extension WeakRefArray: SelfPurgingType {
    public var shouldPurgeLazily: Bool {
        get {
            return self._shouldPurgeLazily
        }
        set(newShouldPurgeLazily) {
            self._shouldPurgeLazily = newShouldPurgeLazily
        }
    }
    
    public func purge() {
        self._purge()
    }
}



// MARK: Array Interface
public extension WeakRefArray {
    
}


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
    
    // ExpressibleByArrayLiteral Implementation
    required public init(arrayLiteral elements: Element...) {
        self._array = elements.map({ WeakWrapper_($0) })
    }
    
    // Private Variable Properties
    fileprivate var _array: [WeakWrapper_]
    fileprivate var _shouldPurgeLazily: Bool = true {
        willSet(newValue) {
            if !newValue && self._shouldPurgeLazily {
                self._purge()
            }
        }
    }
}


// MARK: ExpressibleByArrayLiteral 
// (Implementation in class declaration)
extension WeakRefArray: ExpressibleByArrayLiteral {}


// MARK: CustomStringConvertible
extension WeakRefArray: CustomStringConvertible {
    public var description: String {
        return "WeakRefArray" + self._array.description
    }
}


// MARK: WeakWrapperDelegate
extension WeakRefArray: WeakWrapperDelegate_ {
    func valueDeinitialized(of weakWrapper: WeakWrapper_) {
        if !self._shouldPurgeLazily {
            var rawArray: [WeakWrapper_] = self._array
            if let index: Int = rawArray.index(where: { $0.uuid == weakWrapper.uuid }) {
                rawArray.remove(at: index)
            }
        }
    }
}


// MARK: // Private
// MARK: Array Interface Implementations

// MARK: Purging
private extension WeakRefArray {
    @discardableResult func _purge() -> [Element] {
        var purgedArray: [WeakWrapper_] = []
        var extractedArray: [Element] = []
        
        let rawArray: [WeakWrapper_] = self._array
        
        for wrapper in rawArray {
            if let value: Element = wrapper.value as? Element {
                purgedArray.append(wrapper)
                extractedArray.append(value)
            }
        }
        
        self._array = purgedArray
        
        return extractedArray
    }
}

