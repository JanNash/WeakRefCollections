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
    func valueDeinitialized<T: AnyObject>(of weakWrapper: WeakWrapper_<T>)
}


// MARK: - WeakWrapper_
// MARK: Interface
extension WeakWrapper_ {
    var delegate: WeakWrapperDelegate_? {
        return self._delegate
    }
    
    var value: Value? {
        return self._value
    }
}


// MARK: Struct Declaration
struct WeakWrapper_<Value: AnyObject> {
    // Init
    init(_ value: Value, delegate: WeakWrapperDelegate_? = nil) {
        self._delegate = delegate
        self._value = value
        objc_setAssociatedObject(
            self._value,
            &self._associationKey,
            DeinitCallbackWrapper_(self._deinitDelegateCall),
            .OBJC_ASSOCIATION_RETAIN
        )
    }
    
    // Private Weak Variable Properties
    fileprivate weak var _delegate: WeakWrapperDelegate_?
    fileprivate weak var _value: Value?
    
    // Private Variable Properties
    private var _associationKey: Void?
}


// MARK: // Private
// MARK: Computed Properties
private extension WeakWrapper_ {
    var _deinitDelegateCall: (() -> Void) {
        return {
            self._delegate?.valueDeinitialized(of: self)
        }
    }
}
