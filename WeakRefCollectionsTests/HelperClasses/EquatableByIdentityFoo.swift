//
//  EquatableByIdentityFoo.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 4/9/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

import Foundation


class EquatableByIdentityFoo: Equatable {}

func ==(lhs: EquatableByIdentityFoo, rhs: EquatableByIdentityFoo) -> Bool {
    return lhs === rhs
}
