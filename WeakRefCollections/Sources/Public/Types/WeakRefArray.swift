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
        var previous: WeakWrapper_? = nil
        self._array = s.map(self._wrapMap(&previous))
    }
    
    // ExpressibleByArrayLiteral Implementation
    required public init(arrayLiteral elements: Element...) {
        var previous: WeakWrapper_? = nil
        self._array = elements.map(self._wrapMap(&previous))
    }
    
    // Private Init Helper Function
    private func _wrapMap(_ previous: inout WeakWrapper_?) -> ((Element) -> WeakWrapper_) {
        var _previous: WeakWrapper_? = previous
        return {
            value in
            let wrapper: WeakWrapper_ = WeakWrapper_(value: value, previous: _previous, delegate: self)
            _previous = wrapper
            return wrapper
        }
    }
    
    // Private Variable Properties
    fileprivate var _array: [WeakWrapper_] = []
}


// MARK: ExpressibleByArrayLiteral
// (Implementation in class declaration)
extension WeakRefArray: ExpressibleByArrayLiteral {}


// MARK: CustomStringConvertible
extension WeakRefArray: CustomStringConvertible {
    public var description: String {
        let arrayOfDescriptions: [String] = self._array.map({ String(describing: $0) })
        let joinedArrayDescription: String = arrayOfDescriptions.joined(separator: ", ")
        return "WeakRefArray[\(joinedArrayDescription)]"
    }
}


// MARK: CustomDebugStringConvertible
extension WeakRefArray: CustomDebugStringConvertible {
    public var debugDescription: String {
        let array: [WeakWrapper_] = self._array
        let count: Int = array.count
        let debugDescriptions: [String] = array.map({ $0.debugDescription })
        let joinedDebugDescriptions: String = debugDescriptions.joined(separator: ", \n    ")
        return "WeakRefArray(" +
            "count: \(count), " +
            "array: [" +
            "\n    \(joinedDebugDescriptions)" +
        "])"
    }
}


// MARK: WeakWrapperDelegate
extension WeakRefArray: WeakWrapperDelegate_ {
    func didDisconnect(weakWrapper: WeakWrapper_) {
        self._array.remove(at: weakWrapper.index)
    }
}
