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
    func valueDeinitialized(of weakWrapper: WeakWrapper_)
}


// MARK: - WeakWrapper_
// MARK: Interface
extension WeakWrapper_ {
    var delegate: WeakWrapperDelegate_? {
        return self._delegate
    }
    
    var value: AnyObject? {
        return self._value
    }
    
    var uuid: UUID {
        return self._uuid
    }
}


// MARK: Struct Declaration
struct WeakWrapper_ {
    // Init
    init(_ value: AnyObject, delegate: WeakWrapperDelegate_? = nil) {
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
    fileprivate weak var _value: AnyObject?
    
    // Private Constant Properties
    fileprivate let _uuid: UUID = UUID()
    
    // Private Variable Properties
    private var _associationKey: Void?
}


// MARK: CustomStringConvertible
extension WeakWrapper_: CustomStringConvertible {
    var description: String {
        return ??self.value
    }
}


// MARK: CustomDebugStringConvertible
extension WeakWrapper_: CustomDebugStringConvertible {
    var debugDescription: String {
        return "WeakWrapper_(value: \(??value), uuid: \(self._uuid), delegate: \(??self._delegate))"
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
