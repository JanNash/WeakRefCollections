//
//  WeakWrapper_.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 12/13/16.
//  Copyright © 2016 JanNash. All rights reserved.
//



// MARK: // Internal
// MARK: - WeakWrapperDelegate_
// MARK: Protocol Declaration
protocol WeakWrapperDelegate_: ShortStringConvertible {
    func didDisconnect(weakWrapper: WeakWrapper_)
}


// MARK: - WeakWrapper_
// MARK: Interface
extension WeakWrapper_ {
    // ReadOnly (Set In Init)
    var delegate: WeakWrapperDelegate_? {
        return self._delegate
    }
    
    var value: AnyObject? {
        return self._value
    }
    
    var index: Int {
        return self._index
    }
}


// MARK: Class Declaration
class WeakWrapper_ {
    // Init
    init(value: AnyObject, previous: WeakWrapper_?, delegate: WeakWrapperDelegate_?) {
        let val: AnyObject = value
        
        self._delegate = delegate
        self._value = val
        self._previous = previous
        previous?._next = self
        
        self._index = (previous?.index ?? -1) + 1
        
        objc_setAssociatedObject(
            val,
            &self._associationKey,
            DeinitCallbackWrapper_(self._deinitDelegateCall),
            .OBJC_ASSOCIATION_RETAIN
        )
    }
    
    // Private Weak Variable Properties
    fileprivate weak var _delegate: WeakWrapperDelegate_?
    fileprivate weak var _value: AnyObject?
    
    // Private Variable Properties
    private var _associationKey: Void?
    
    fileprivate var _index: Int = 0 {
        didSet {
            self._next?._index = self.index + 1
        }
    }
    
    fileprivate var _next: WeakWrapper_?
    fileprivate var _previous: WeakWrapper_?
}


// MARK: CustomStringConvertible
extension WeakWrapper_: CustomStringConvertible {
    var description: String {
        return ??self._value
    }
}


// MARK: CustomDebugStringConvertible
extension WeakWrapper_: CustomDebugStringConvertible {
    var debugDescription: String {
        return
            "\(self.shortDescription)(" +
            "value: \(??self._value), " +
            "index: \(self._index), " +
            "previous: \(??self._previous?.shortDescription), " +
            "next: \(??self._next?.shortDescription), " +
            "delegate: \(??self._delegate?.shortDescription))"
    }
}


// MARK: ShortStringConvertible
extension WeakWrapper_: ShortStringConvertible {}


// MARK: // Private
// MARK: Computed Properties
private extension WeakWrapper_ {
    var _deinitDelegateCall: (() -> Void) {
        return {
            self._previous?._next = self._next
            self._next?._previous = self._previous
            self._next?._index -= 1
            self._delegate?.didDisconnect(weakWrapper: self)
        }
    }
}
