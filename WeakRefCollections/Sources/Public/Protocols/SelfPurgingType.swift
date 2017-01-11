//
//  SelfPurgingType.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 1/11/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

import Foundation


// MARK: // Public
// MARK: Protocol Declaration
public protocol SelfPurgingType: class {
    var shouldPurgeLazily: Bool { get set }
    func purge()
}
