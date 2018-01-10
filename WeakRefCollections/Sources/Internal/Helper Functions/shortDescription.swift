//
//  shortDescription.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 1/15/17.
//  Copyright © 2017 JanNash. All rights reserved.
//


// MARK: // Internal
// MARK: Function Declarations
func shortDescription(of object: AnyObject) -> String {
    return _shortDescription(of: object)
}


func shortDescription(of object: AnyObject?) -> String {
    return _shortDescription(of: object)
}


// MARK: // Private
// MARK: Function Implementations
private func _shortDescription(of object: AnyObject) -> String {
    let typeString: String = "\(type(of: object))"
    let identifierString: String = ObjectIdentifier(object).debugDescription
    let prefixRemoved: String = identifierString.replacingOccurrences(of: "ObjectIdentifier(0x", with: "")
    let identityString: String = prefixRemoved.replacingOccurrences(of: ")", with: "")
    let range: NSRange = NSMakeRange(0, identityString.count)
    let regex: NSRegularExpression = try! NSRegularExpression(pattern: "^0*", options: .caseInsensitive)
    let stringWithPurgedLeadingZeroes: String = regex.stringByReplacingMatches(in: identityString, range: range, withTemplate: "")
    return "<\(typeString): \(stringWithPurgedLeadingZeroes)>"
}


private func _shortDescription(of object: AnyObject?) -> String {
    if let unwrappedObject: AnyObject = object {
        return _shortDescription(of: unwrappedObject)
    }
    return "nil"
}
