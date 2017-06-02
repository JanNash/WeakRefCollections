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
    }
}
