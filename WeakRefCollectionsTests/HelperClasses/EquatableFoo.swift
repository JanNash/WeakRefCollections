//
//  EquatableFoo.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 4/9/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

import Foundation


class EquatableFoo {
    init(value: Int) {
        self.value = value
    }
    
    var value: Int
}

extension EquatableFoo: Equatable {
    static func ==(lhs: EquatableFoo, rhs: EquatableFoo) -> Bool {
        return lhs.value == rhs.value
    }
}
