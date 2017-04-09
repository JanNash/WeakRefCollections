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
protocol WeakWrapperDelegate_: class {
    func didDisconnect<Value>(weakWrapper: WeakWrapper_<Value>)
}


// MARK: - WeakWrapper_
// MARK: Interface
extension WeakWrapper_ {
    // ReadOnly (Set In Init)
    var delegate: WeakWrapperDelegate_? {
        return self._delegate
    }
    
    var value: Value? {
        return self._value
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
    
    // Private Weak Variable Properties
    fileprivate weak var _delegate: WeakWrapperDelegate_?
    fileprivate weak var _value: Value?
    
    // Private Variable Properties
    private var _associationKey: Void?
    
    // // // // // // // // // // // // //
    
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


// MARK: Equatable
extension WeakWrapper_ where Value : Equatable {}
func ==<Value>(lhs: WeakWrapper_<Value>, rhs: WeakWrapper_<Value>) -> Bool where Value : Equatable {
    return lhs._value == rhs._value
}

func !=<Value>(lhs: WeakWrapper_<Value>, rhs: WeakWrapper_<Value>) -> Bool where Value : Equatable {
    return lhs._value != rhs._value
}


// MARK: // Private
// MARK: Computed Properties
private extension WeakWrapper_ {
    var _deinitDelegateCall: (() -> Void) {
        return {
            self.delegate?.didDisconnect(weakWrapper: self)
        }
    }
}
