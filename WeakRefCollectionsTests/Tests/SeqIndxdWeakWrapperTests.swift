//
//  ArrayWeakWrapperTests.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 4/10/17.
//  Copyright © 2017 JanNash. All rights reserved.
//


import XCTest
@testable import WeakRefCollections


class SeqIndxdWeakWrapperTests: BaseTest {
    typealias Wrapper<T: AnyObject> = SeqIndxdWeakWrapper_<T>
    typealias EqFoo = EquatableFoo
    
    func testEqualIfValueEqual() {
        let foo0: EqFoo = EqFoo(value: 0)
        let foo1: EqFoo = EqFoo(value: 0)
        
        let weak0: Wrapper<EqFoo> = Wrapper(value: foo0, previous: nil, delegate: nil)
        let weak1: Wrapper<EqFoo> = Wrapper(value: foo1, previous: nil, delegate: nil)
        
        XCTAssertTrue(weak0 == weak1)
        XCTAssertFalse(weak0 != weak1)
    }
    
    func testNotEqualIfValueNotEqual() {
        let foo0: EqFoo = EqFoo(value: 0)
        let foo1: EqFoo = EqFoo(value: 1)
        
        let weak0: Wrapper<EqFoo> = Wrapper(value: foo0, previous: nil, delegate: nil)
        let weak1: Wrapper<EqFoo> = Wrapper(value: foo1, previous: nil, delegate: nil)
        
        XCTAssertFalse(weak0 == weak1)
        XCTAssertTrue(weak0 != weak1)
    }
    
    func testIndexWithOneWrapper() {
        let foo: Foo = Foo()
        
        let weak0: Wrapper<Foo> = Wrapper(value: foo, previous: nil, delegate: nil)
        
        XCTAssertEqual(weak0.index, 0)
    }
    
    func testIndicesWithThreeWrappers1() {
        let foo0: EqFoo = EqFoo(value: 0)
        var foo1: EqFoo? = EqFoo(value: 1)
        let foo2: EqFoo = EqFoo(value: 2)
        
        let weak0: Wrapper<EqFoo> = Wrapper(value: foo0, previous: nil, delegate: nil)
        let weak1: Wrapper<EqFoo> = Wrapper(value: foo1!, previous: weak0, delegate: nil)
        let weak2: Wrapper<EqFoo> = Wrapper(value: foo2, previous: weak1, delegate: nil)
        
        XCTAssertEqual(weak0.index, 0)
        XCTAssertEqual(weak1.index, 1)
        XCTAssertEqual(weak2.index, 2)
        
        foo1 = nil
        
        XCTAssertEqual(weak0.index, 0)
        XCTAssertEqual(weak1.index, 1)
        XCTAssertEqual(weak2.index, 1)
    }
    
    func testIndicesWithThreeWrappers2() {
        var foo0: EqFoo? = EqFoo(value: 0)
        let foo1: EqFoo = EqFoo(value: 1)
        let foo2: EqFoo = EqFoo(value: 2)
        
        let weak0: Wrapper<EqFoo> = Wrapper(value: foo0!, previous: nil, delegate: nil)
        let weak1: Wrapper<EqFoo> = Wrapper(value: foo1, previous: weak0, delegate: nil)
        let weak2: Wrapper<EqFoo> = Wrapper(value: foo2, previous: weak1, delegate: nil)
        
        XCTAssertEqual(weak0.index, 0)
        XCTAssertEqual(weak1.index, 1)
        XCTAssertEqual(weak2.index, 2)
        
        foo0 = nil
        
        XCTAssertEqual(weak0.index, 0)
        XCTAssertEqual(weak1.index, 0)
        XCTAssertEqual(weak2.index, 1)
    }
    
    func testAdditionalDebugDescription() {
        let additionalDebugDescription: String = Wrapper(value: Foo(), previous: nil, delegate: nil).additionalDebugDescription
        XCTAssertFalse(additionalDebugDescription.isEmpty)
    }
}
