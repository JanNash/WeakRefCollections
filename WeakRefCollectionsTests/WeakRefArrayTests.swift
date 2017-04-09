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
        let ary1: WeakRefArray<Foo> = []
        let ary2: WeakRefArray<Foo> = WeakRefArray()
        XCTAssert(ary1 == ary2)
    }
    
    
    
    func testEmptyArray() {
        let ary: WeakRefArray<Foo> = []
        XCTAssert(ary.isEmpty)
    }
}
