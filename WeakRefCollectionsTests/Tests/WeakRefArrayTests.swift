//
//  WeakRefArrayTests.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 1/15/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

import XCTest
@testable import WeakRefCollections


class WeakRefArrayTests: BaseTest {
    func testArrayLiteralConversion1() {
        let ary1: WeakRefArray<EquatableByIdentityFoo> = []
        let ary2: WeakRefArray<EquatableByIdentityFoo> = WeakRefArray()
        
        // This doesn't compile and I don't get why...
//        XCTAssertEqual(ary1, ary2)
        
        XCTAssert(ary1 == ary2)
    }
    
    
    
    func testEmptyArray() {
        let ary: WeakRefArray<Foo> = []
        XCTAssert(ary.isEmpty)
    }
}
