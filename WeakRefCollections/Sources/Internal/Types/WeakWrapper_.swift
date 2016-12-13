//
//  WeakWrapper_.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 12/13/16.
//  Copyright © 2016 JanNash. All rights reserved.
//

import Foundation


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
        get {
            return self._delegate
        }
        set(newDelegate) {
            self._delegate = newDelegate
        }
    }
    
    var value: T? {
        get {
            return self._value
        }
        set(newValue) {
            self._value = newValue
        }
    }
}


// MARK: Struct Declaration
struct WeakWrapper_<T: AnyObject> {
    // Init
    init(_ value: T? = nil) {
        self._value = value
    }
    
    // Private Weak Variable Properties
    fileprivate weak var _delegate: WeakWrapperDelegate_?
    
    // Private Variable Properties
    private var _associationKey: Void?
    fileprivate weak var _value: T? {
        didSet {
            if self._value != nil {
                objc_setAssociatedObject(
                    self._value,
                    &self._associationKey,
                    DeallocBackCaller_(self._deinitDelegateCall),
                    .OBJC_ASSOCIATION_RETAIN
                )
            }
        }
    }
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
