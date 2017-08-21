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
    
    func testIndexAfter() {
        let foo1: EquatableFoo = EquatableFoo(value: 1)
        let foo2: EquatableFoo = EquatableFoo(value: 2)
        
        let ary: WeakRefArray<EquatableFoo> = [foo1, foo2]
        guard let index: Int = ary.index(of: foo1) else {
            XCTFail()
            return
        }
        
        let indexAfter: Int = ary.index(after: index)
        
        XCTAssertNotEqual(index, indexAfter)
    }
    
    func testRemovingElementManually() {
        var foo1: EquatableFoo? = EquatableFoo(value: 1)
        let foo2: EquatableFoo = EquatableFoo(value: 2)
        
        var ary1: WeakRefArray<EquatableFoo> = [foo1!, foo2]
        
        guard let index: Int = ary1.index(of: foo1!) else {
            XCTFail()
            return
        }
        
        ary1.remove(at: index)
        
        foo1 = nil
        
        XCTAssertEqual(ary1.count, 1)
    }
    
    func testDescription() {
        var ary: WeakRefArray<EquatableFoo> = []
        let description: String = ary.description
        XCTAssertFalse(description.isEmpty)
        
        let count: Int = description.characters.count
        let foo: EquatableFoo = EquatableFoo(value: 1)
        ary.append(foo)
        
        let newDescription: String = ary.description
        XCTAssertFalse(newDescription.isEmpty)
        
        let newCount: Int = newDescription.characters.count
        XCTAssertNotEqual(count, newCount)
    }
    
    func testDebugDescription() {
        var ary: WeakRefArray<EquatableFoo> = []
        let description: String = ary.debugDescription
        XCTAssertFalse(description.isEmpty)
        
        let count: Int = description.characters.count
        let foo: EquatableFoo = EquatableFoo(value: 1)
        ary.append(foo)
        
        let newDescription: String = ary.debugDescription
        XCTAssertFalse(newDescription.isEmpty)
        
        let newCount: Int = newDescription.characters.count
        XCTAssertNotEqual(count, newCount)
    }
}
