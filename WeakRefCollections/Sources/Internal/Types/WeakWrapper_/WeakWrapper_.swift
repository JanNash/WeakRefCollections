//
//  WeakWrapper_.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 12/13/16.
//  Copyright © 2016 JanNash. All rights reserved.
//


// MARK: // Internal
// MARK: - WeakWrapperDelegate_
protocol WeakWrapperDelegate_: class {
    func disconnected<Value>(weakWrapper: WeakWrapper_<Value>)
}


// MARK: - WeakWrapper_
// MARK: Interface
extension WeakWrapper_ {
    // Readonly
    var value: Value? {
        return self._value
    }
    
    // ReadWrite
    var delegate: WeakWrapperDelegate_? {
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
}


// MARK: Class Declaration
class WeakWrapper_<Value: AnyObject> {
    // Init
    init(value: Value, delegate: WeakWrapperDelegate_?) {
        let val: Value = value
        
        self._delegate = delegate
        self._value = val
        
        objc_setAssociatedObject(
            val,
            &self._associationKey,
            DeinitCallbackWrapper_(self.deinitDelegateCall),
            .OBJC_ASSOCIATION_RETAIN
        )
    }
    
    // Private Weak Variables
    private weak var _delegate: WeakWrapperDelegate_?
    private weak var _value: Value?
    
    // Private Variables
    private var _associationKey: Void?
    
    
    // MARK: CustomDebugStringConvertible Helper
    // (Declared in Class Declaration so it can be overridden)
    var additionalDebugDescription: String {
        return ""
    }
    
    // MARK: DeinitCallbackWrapper Callback
    var deinitDelegateCall: (() -> Void) {
        return self._deinitDelegateCall
    }
}


// MARK: Conditional Equatable Conformance
extension WeakWrapper_: Equatable where Value: Equatable {
    static func == (lhs: WeakWrapper_<Value>, rhs: WeakWrapper_<Value>) -> Bool {
        return lhs.value == rhs.value
    }
}


// MARK: CustomStringConvertible
extension WeakWrapper_: CustomStringConvertible {
    final var description: String {
        return ??self._value
    }
}


// MARK: CustomDebugStringConvertible
extension WeakWrapper_: CustomDebugStringConvertible {
    var debugDescription: String {
        return
            "\(shortDescription(of: self))(" +
            "value: \(??self._value), " +
            "delegate: \(shortDescription(of: self._delegate))" +
            "\(self.additionalDebugDescription))"
    }
}


// MARK: // Private
// MARK: Computed Variables
private extension WeakWrapper_ {
    var _deinitDelegateCall: (() -> Void) {
        return {
            self.delegate?.disconnected(weakWrapper: self)
        }
    }
}
