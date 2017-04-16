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
    func testNormalInitIsEmpty() {
        let ary: WeakRefArray<Foo> = WeakRefArray()
        XCTAssertTrue(ary.isEmpty)
    }
    
    func testInitWithSequenceIsEmpty() {
        let ary: WeakRefArray<Foo> = WeakRefArray([])
        XCTAssertTrue(ary.isEmpty)
    }
    
    func testArrayLiteralInitIsEmpty() {
        let ary: WeakRefArray<Foo> = []
        XCTAssertTrue(ary.isEmpty)
    }
    
    func testEqualWithAllThreeInitsEmpty() {
        let ary1: WeakRefArray<EquatableFoo> = WeakRefArray()
        let ary2: WeakRefArray<EquatableFoo> = WeakRefArray([])
        let ary3: WeakRefArray<EquatableFoo> = []
        
        XCTAssertTrue(ary1 == ary2)
        XCTAssertTrue(ary1 == ary3)
        XCTAssertTrue(ary2 == ary3)
    }
    
    func testEqualWithTwoNonEmptyInitsAndOneEqualElement() {
        let foo1: EquatableFoo = EquatableFoo(value: 1)
        let foo2: EquatableFoo = EquatableFoo(value: 1)
        
        let ary1: WeakRefArray<EquatableFoo> = WeakRefArray([foo1])
        let ary2: WeakRefArray<EquatableFoo> = [foo2]
        
        XCTAssertTrue(ary1 == ary2)
    }
    
    func testEqualEmpty() {
        let ary1: WeakRefArray<EquatableFoo> = WeakRefArray()
        let ary2: WeakRefArray<EquatableFoo> = WeakRefArray()
        
        XCTAssertTrue(ary1 == ary2)
    }
    
    func testEqualWithOneEqualElement() {
        let foo1: EquatableFoo = EquatableFoo(value: 1)
        let foo2: EquatableFoo = EquatableFoo(value: 1)
        
        let ary1: WeakRefArray<EquatableFoo> = [foo1]
        let ary2: WeakRefArray<EquatableFoo> = [foo2]
        
        XCTAssertTrue(ary1 == ary2)
    }
    
    func testNotEqualWithOneNotEqualElement() {
        let foo1: EquatableFoo = EquatableFoo(value: 1)
        let foo2: EquatableFoo = EquatableFoo(value: 2)
        
        let ary1: WeakRefArray<EquatableFoo> = [foo1]
        let ary2: WeakRefArray<EquatableFoo> = [foo2]
        
        XCTAssertTrue(ary1 != ary2)
    }
}
