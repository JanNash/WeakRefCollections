//
//  ArrayWeakWrapper_.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 1/15/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

import Foundation


// MARK: // Internal
// MARK: - ArrayWeakWrapper_
// MARK: Interface
extension ArrayWeakWrapper_ {
    // ReadOnly
    var index: Int {
        return self._index
    }
}


// MARK: Class Declaration
class ArrayWeakWrapper_: WeakWrapper_ {
    // Init
    init(value: AnyObject, previous: ArrayWeakWrapper_?, delegate: WeakWrapperDelegate_?) {
        self._index = (previous?.index ?? -1) + 1
        
        super.init(value: value, delegate: delegate)
        
        self._previous = previous
        previous?._next = self
    }
    
    // Private Variable Properties
    fileprivate var _index: Int {
        didSet {
            self._next?._index = self.index + 1
        }
    }
    
    fileprivate var _next: ArrayWeakWrapper_?
    fileprivate var _previous: ArrayWeakWrapper_?

    // // // // // // // // // // // // //
    
    // MARK: CustomDebugStringConvertible Helper Override
    override var additionalDebugDescription: String {
        return ", " +
            "index: \(self._index), " +
            "previous: \(shortDescription(of: self._previous)), " +
            "next: \(shortDescription(of: self._next))"
    }
    
    // MARK: DeinitCallbackWrapper Callback Override
    override var deinitDelegateCall: (() -> Void) {
        return {
            self._deinitDelegateCall()
            super.deinitDelegateCall()
        }
    }
}


// MARK: // Private
// MARK: Computed Properties
private extension ArrayWeakWrapper_ {
    var _deinitDelegateCall: (() -> Void) {
        return {
            self._next?._index = self._index
            self._previous?._next = self._next
            self._next?._previous = self._previous
        }
    }
}
