//
//  WeakRefArray.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 12/17/16.
//  Copyright © 2016 JanNash. All rights reserved.
//


// MARK: // Public
// MARK: Class Declaration
final public class WeakRefArray<Element: AnyObject> {
    // Array Inits
    required public init() {}
    required public init<S>(_ elements: S) where S : Sequence, Element == S.Element {
        var previous: SeqIndxdWeakWrapper_<Element>? = nil
        self._array = elements.map(self._wrapMap(&previous))
    }
    
    // ExpressibleByArrayLiteral Implementation
    required public init(arrayLiteral elements: Element...) {
        var previous: SeqIndxdWeakWrapper_<Element>? = nil
        self._array = elements.map(self._wrapMap(&previous))
    }
    
    // Private Variables
    private var _array: [SeqIndxdWeakWrapper_<Element>] = []
}


// MARK: ExpressibleByArrayLiteral
// (Implementation in Class Declaration)
extension WeakRefArray: ExpressibleByArrayLiteral {}


// MARK: Equatable
extension WeakRefArray: Equatable where Element: Equatable {
    public static func == (lhs: WeakRefArray<Element>, rhs: WeakRefArray<Element>) -> Bool {
        return lhs._array == rhs._array
    }
}


// MARK: CustomStringConvertible
extension WeakRefArray: CustomStringConvertible {
    public var description: String {
        return self._description
    }
}


// MARK: CustomDebugStringConvertible
extension WeakRefArray: CustomDebugStringConvertible {
    public var debugDescription: String {
        return self._debugDescription
    }
}


// MARK: Collection
extension WeakRefArray: Collection {
    public typealias Index = Int
    
    public var startIndex: Index {
        return self._array.startIndex
    }
    
    public var endIndex: Index {
        return self._array.endIndex
    }
    
    public func index(after i: Index) -> Index {
        return self._array.index(after: i)
    }
    
    public subscript(index: Index) -> Element {
        return self._array[index].value!
    }
}


// MARK: RangeReplaceableCollection
extension WeakRefArray: RangeReplaceableCollection {
    public func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C : Collection, R : RangeExpression, Element == C.Element, Int == R.Bound {
        self._replaceSubrange(subrange, with: newElements)
    }
}


// MARK: // Internal
// MARK: WeakWrapperDelegate
extension WeakRefArray: WeakWrapperDelegate_ {
    func disconnected<Element>(weakWrapper: WeakWrapper_<Element>) {
        self._array.remove(at: (weakWrapper as! SeqIndxdWeakWrapper_).index)
    }
}


// MARK: // Private
// MARK: CustomStringConvertible Implementation
private extension WeakRefArray/*: CustomStringConvertible*/ {
    var _description: String {
        let arrayOfDescriptions: [String] = self._array.map({ String(describing: $0) })
        let joinedArrayDescription: String = arrayOfDescriptions.joined(separator: ", ")
        return "WeakRefArray[\(joinedArrayDescription)]"
    }
}


// MARK: CustomDebugStringConvertible Implementation
private extension WeakRefArray/*: CustomDebugStringConvertible*/ {
    var _debugDescription: String {
        let array: [SeqIndxdWeakWrapper_] = self._array
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


// MARK: RangeReplaceableCollection Implementation
private extension WeakRefArray/*: RangeReplaceableCollection*/ {
    func _replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C : Collection, R : RangeExpression, Element == C.Element, Int == R.Bound {
        let oldElements: ArraySlice<SeqIndxdWeakWrapper_<Element>> = self._array[subrange]
        oldElements.forEach({ $0.delegate = nil })
        
        var previous: SeqIndxdWeakWrapper_<Element>? = nil
        self._array.replaceSubrange(subrange, with: newElements.map(self._wrapMap(&previous)))
    }
}


// MARK: Wrapping Helper Function
private extension WeakRefArray {
    func _wrapMap(_ previous: inout SeqIndxdWeakWrapper_<Element>?) -> ((Element) -> SeqIndxdWeakWrapper_<Element>) {
        var _previous: SeqIndxdWeakWrapper_? = previous
        return {
            let wrapper: SeqIndxdWeakWrapper_ = SeqIndxdWeakWrapper_(value: $0, previous: _previous, delegate: self)
            _previous = wrapper
            return wrapper
        }
    }
}
