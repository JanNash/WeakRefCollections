//
//  WeakRefArray.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 12/17/16.
//  Copyright © 2016 JanNash. All rights reserved.
//


// MARK: // Public
// MARK: Class Declaration
public class WeakRefArray<Element: AnyObject> {
    // Array Inits
    required public init() {
        self._array = []
    }
    
    required public init<S : Sequence>(_ s: S) where S.Iterator.Element == Element {
        var previous: ArrayWeakWrapper_<Element>? = nil
        self._array = s.map(self._wrapMap(&previous))
    }
    
    // ExpressibleByArrayLiteral Implementation
    required public init(arrayLiteral elements: Element...) {
        var previous: ArrayWeakWrapper_<Element>? = nil
        self._array = elements.map(self._wrapMap(&previous))
    }
    
    // Private Variable Properties
    fileprivate var _array: [ArrayWeakWrapper_<Element>] = []
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
        let array: [ArrayWeakWrapper_] = self._array
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


// MARK: Pseudo-Equatable
// Waiting for https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md
public func ==<Element>(lhs: WeakRefArray<Element>, rhs: WeakRefArray<Element>) -> Bool where Element : Equatable  {
    return lhs._array.elementsEqual(rhs._array, by: { $0.0.value == $0.1.value })
}

public func !=<Element>(lhs: WeakRefArray<Element>, rhs: WeakRefArray<Element>) -> Bool where Element : Equatable {
    return !(lhs == rhs)
}


// MARK: WeakWrapperDelegate
extension WeakRefArray: WeakWrapperDelegate_ {
    func didDisconnect<Element>(weakWrapper: WeakWrapper_<Element>) {
        self._array.remove(at: (weakWrapper as! ArrayWeakWrapper_).index)
    }
}


// MARK: Collection
extension WeakRefArray: Collection {
    public var startIndex: Int {
        return self._array.startIndex
    }
    
    public var endIndex: Int {
        return self._array.endIndex
    }
    
    public func index(after i: Int) -> Int {
        return self._array.index(after: i)
    }
    
    public subscript(index: Int) -> Element {
        return self._array[index].value!
    }
}


// MARK: RangeReplaceableCollection
extension WeakRefArray: RangeReplaceableCollection {
    public func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where C : Collection, C.Iterator.Element == Element {
        var previous: ArrayWeakWrapper_<Element>? = nil
        self._array[subrange] = ArraySlice(newElements.map(self._wrapMap(&previous)))
    }
}


// MARK: // Private
// MARK: Wrapping Helper Function
private extension WeakRefArray {
    func _wrapMap(_ previous: inout ArrayWeakWrapper_<Element>?) -> ((Element) -> ArrayWeakWrapper_<Element>) {
        var _previous: ArrayWeakWrapper_? = previous
        return {
            value in
            let wrapper: ArrayWeakWrapper_ = ArrayWeakWrapper_(value: value, previous: _previous, delegate: self)
            _previous = wrapper
            return wrapper
        }
    }
}
