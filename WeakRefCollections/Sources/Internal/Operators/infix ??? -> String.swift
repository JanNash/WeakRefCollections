//
//  infix ??? -> String.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 1/11/17.
//
//  Thank you, Ole Begemann
//  https://oleb.net/blog/2016/12/optionals-string-interpolation/
//


// MARK: // Internal
// MARK: Operator Declaration
infix operator ??? : NilCoalescingPrecedence


// MARK: Operator Implementation
func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    switch optional {
    case let value?:
        return "\(value)"
    case nil:
        return defaultValue()
    }
}
