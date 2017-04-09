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
        
        XCTAssertTrue(ary1 == ary2)
    }
    
    func testArrayLiteralConversionEmpty() {
        let ary1: WeakRefArray<EquatableFoo> = []
        let ary2: WeakRefArray<EquatableFoo> = WeakRefArray()
        
//         This doesn't compile and I don't get why...
//         XCTAssertEqual(ary1, ary2)
        
        XCTAssertTrue(ary1 == ary2)
    }
    
    func testEquatableWithOneEqualElementEqual() {
        let foo1: EquatableFoo = EquatableFoo(value: 1)
        let foo2: EquatableFoo = EquatableFoo(value: 1)
        
        let ary1: WeakRefArray<EquatableFoo> = [foo1]
        let ary2: WeakRefArray<EquatableFoo> = [foo2]
        
        XCTAssertTrue(ary1 == ary2)
    }
    
    func testEquatableWithOneNotEqualElementNotEqual() {
        let foo1: EquatableFoo = EquatableFoo(value: 1)
        let foo2: EquatableFoo = EquatableFoo(value: 2)
        
        let ary1: WeakRefArray<EquatableFoo> = [foo1]
        let ary2: WeakRefArray<EquatableFoo> = [foo2]
        
        XCTAssertTrue(ary1 != ary2)
    }
    
    func testIsEmpty() {
        let ary: WeakRefArray<Foo> = []
        XCTAssertTrue(ary.isEmpty)
    }
}
