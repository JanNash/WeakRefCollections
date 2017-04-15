//
//  ArrayWeakWrapperTests.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 4/10/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

import XCTest
@testable import WeakRefCollections


class ArrayWeakWrapperTests: BaseTest {
    func testEquatableEqualIfValueEqual() {
        let foo1: EquatableFoo = EquatableFoo(value: 1)
        let foo2: EquatableFoo = EquatableFoo(value: 1)
        
        let weak1: ArrayWeakWrapper_<EquatableFoo> = ArrayWeakWrapper_(value: foo1, previous: nil, delegate: nil)
        let weak2: ArrayWeakWrapper_<EquatableFoo> = ArrayWeakWrapper_(value: foo2, previous: nil, delegate: nil)
        
        XCTAssertTrue(weak1 == weak2)
        XCTAssertFalse(weak1 != weak2)
    }
    
    func testEquatableNotEqualIfValueNotEqual() {
        let foo1: EquatableFoo = EquatableFoo(value: 1)
        let foo2: EquatableFoo = EquatableFoo(value: 2)
        
        let weak1: ArrayWeakWrapper_<EquatableFoo> = ArrayWeakWrapper_(value: foo1, previous: nil, delegate: nil)
        let weak2: ArrayWeakWrapper_<EquatableFoo> = ArrayWeakWrapper_(value: foo2, previous: nil, delegate: nil)
        
        XCTAssertFalse(weak1 == weak2)
        XCTAssertTrue(weak1 != weak2)
    }
}
