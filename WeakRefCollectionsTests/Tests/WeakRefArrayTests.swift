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
    func testEquatableEmpty() {
        let ary1: WeakRefArray<EquatableFoo> = WeakRefArray()
        let ary2: WeakRefArray<EquatableFoo> = WeakRefArray()
        
        XCTAssert(ary1 == ary2)
    }
    
    func testArrayLiteralConversionEmpty() {
        let ary1: WeakRefArray<EquatableFoo> = []
        let ary2: WeakRefArray<EquatableFoo> = WeakRefArray()
        
//         This doesn't compile and I don't get why...
//         XCTAssertEqual(ary1, ary2)
        
        XCTAssert(ary1 == ary2)
    }
    
    func testEquatableInitializedWithOneElement() {
        
        let a: EquatableFoo = EquatableFoo(value: 1)
        let b: EquatableFoo = EquatableFoo(value: 1)
        
        XCTAssert(a == b)
        
        let ary1: WeakRefArray<EquatableFoo> = []
        let ary2: WeakRefArray<EquatableFoo> = []
        
        XCTAssert(ary1 == ary2)
    }
    
    func testIsEmpty() {
        let ary: WeakRefArray<Foo> = []
        XCTAssert(ary.isEmpty)
    }
}
