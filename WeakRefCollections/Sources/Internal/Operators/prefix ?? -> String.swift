//
//  prefix ?? -> String.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 1/12/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

import Foundation


// MARK: // Internal
// MARK: Operator Declaration
prefix operator ??


// MARK: Operator Implementation
public prefix func ??<T>(optional: T?) -> String {
    return "\(optional ??? "nil")"
}
