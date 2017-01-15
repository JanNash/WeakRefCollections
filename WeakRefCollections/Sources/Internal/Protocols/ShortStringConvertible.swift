//
//  ShortStringConvertible.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 1/15/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

import Foundation


// MARK: // Internal
// MARK: Protocol Declaration
protocol ShortStringConvertible: class {
    var shortDescription: String { get }
}


// MARK: Default Implementation
extension ShortStringConvertible {
    var shortDescription: String {
        var mutableSelf: Self = self
        var memoryAddress: String = ""
        withUnsafePointer(to: &mutableSelf) {
            memoryAddress = "\($0)"
        }
        
        let typeString: String = "\(type(of: self))"
        return "<\(typeString): \(memoryAddress)>"
    }
}
