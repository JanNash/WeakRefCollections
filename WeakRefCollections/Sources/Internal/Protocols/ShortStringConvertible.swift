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
        let typeString: String = "\(type(of: self))"
        let identifierString: String = ObjectIdentifier(self).debugDescription
        let prefixRemoved: String = identifierString.replacingOccurrences(of: "ObjectIdentifier(", with: "")
        let identityString: String = prefixRemoved.replacingOccurrences(of: ")", with: "")
        return "<\(typeString): \(identityString)>"
    }
}
