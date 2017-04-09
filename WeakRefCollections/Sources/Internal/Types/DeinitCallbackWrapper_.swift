//
//  DeinitCallbackWrapper_.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 12/13/16.
//  Copyright © 2016 JanNash. All rights reserved.
//



// MARK: // Internal
// MARK: Class Declaration
class DeinitCallbackWrapper_ {
    // Init
    init(_ deinitCallback: @escaping (() -> Void)) {
        self._deinitCallback = deinitCallback
    }
    
    // Deinit
    deinit {
        self._deinitCallback()
    }
    
    // Private Variable Properties
    private var _deinitCallback: (() -> Void)
}
