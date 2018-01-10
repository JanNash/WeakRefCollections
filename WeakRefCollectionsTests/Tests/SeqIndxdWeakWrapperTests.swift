//
//  ArrayWeakWrapperTests.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 4/10/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

// !!!: The numbering of the foos and of the wrappers is a mess.


import XCTest
@testable import WeakRefCollections


class SeqIndxdWeakWrapperTests: BaseTest {
    typealias Wrapper<T: AnyObject> = SeqIndxdWeakWrapper_<T>
    typealias EqFoo = EquatableFoo
    
    func testEqualIfValueEqual() {
        let foo1: EqFoo = EqFoo(value: 1)
        let foo2: EqFoo = EqFoo(value: 1)
        
        let weak1: Wrapper<EqFoo> = Wrapper(value: foo1, previous: nil, delegate: nil)
        let weak2: Wrapper<EqFoo> = Wrapper(value: foo2, previous: nil, delegate: nil)
        
        XCTAssertTrue(weak1 == weak2)
        XCTAssertFalse(weak1 != weak2)
    }
    
    func testNotEqualIfValueNotEqual() {
        let foo1: EqFoo = EqFoo(value: 1)
        let foo2: EqFoo = EqFoo(value: 2)
        
        let weak1: Wrapper<EqFoo> = Wrapper(value: foo1, previous: nil, delegate: nil)
        let weak2: Wrapper<EqFoo> = Wrapper(value: foo2, previous: nil, delegate: nil)
        
        XCTAssertFalse(weak1 == weak2)
        XCTAssertTrue(weak1 != weak2)
    }
    
    func testIndexWithOneWrapper() {
        let foo: Foo = Foo()
        
        let weak1: Wrapper<Foo> = Wrapper(value: foo, previous: nil, delegate: nil)
        
        XCTAssertEqual(weak1.index, 0)
    }
    
    func testIndicesWithThreeWrappers1() {
        // ???: Why did I start counting at 1 for the Foos and at 0 for the wrappers?
        let foo1: EqFoo = EqFoo(value: 1)
        var foo2: EqFoo? = EqFoo(value: 2)
        let foo3: EqFoo = EqFoo(value: 3)
        
        let weak0: Wrapper<EqFoo> = Wrapper(value: foo1, previous: nil, delegate: nil)
        let weak1: Wrapper<EqFoo> = Wrapper(value: foo2!, previous: weak0, delegate: nil)
        let weak2: Wrapper<EqFoo> = Wrapper(value: foo3, previous: weak1, delegate: nil)
        
        XCTAssertEqual(weak0.index, 0)
        XCTAssertEqual(weak1.index, 1)
        XCTAssertEqual(weak2.index, 2)
        
        foo2 = nil
        
        XCTAssertEqual(weak0.index, 0)
        XCTAssertEqual(weak1.index, 1)
        XCTAssertEqual(weak2.index, 1)
    }
    
    func testIndicesWithThreeWrappers2() {
        // ???: Why did I start counting at 1 for the Foos and at 0 for the wrappers?
        var foo1: EqFoo? = EqFoo(value: 1)
        let foo2: EqFoo = EqFoo(value: 2)
        let foo3: EqFoo = EqFoo(value: 3)
        
        let weak0: Wrapper<EqFoo> = Wrapper(value: foo1!, previous: nil, delegate: nil)
        let weak1: Wrapper<EqFoo> = Wrapper(value: foo2, previous: weak0, delegate: nil)
        let weak2: Wrapper<EqFoo> = Wrapper(value: foo3, previous: weak1, delegate: nil)
        
        XCTAssertEqual(weak0.index, 0)
        XCTAssertEqual(weak1.index, 1)
        XCTAssertEqual(weak2.index, 2)
        
        foo1 = nil
        
        XCTAssertEqual(weak0.index, 0)
        XCTAssertEqual(weak1.index, 0)
        XCTAssertEqual(weak2.index, 1)
    }
    
    func testAdditionalDebugDescription() {
        let additionalDebugDescription: String = Wrapper(value: Foo(), previous: nil, delegate: nil).additionalDebugDescription
        XCTAssertFalse(additionalDebugDescription.isEmpty)
    }
}
