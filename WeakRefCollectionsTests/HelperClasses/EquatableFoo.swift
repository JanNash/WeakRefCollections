//
//  EquatableFoo.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 4/9/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

import Foundation


class EquatableFoo: Equatable {
    init(value: Int) {
        self.value = value
    }
    
    var value: Int
}

func ==(lhs: EquatableFoo, rhs: EquatableFoo) -> Bool {
    return lhs.value == rhs.value
}
