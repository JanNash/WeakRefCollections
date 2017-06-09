//
//  BaseTest.swift
//  WeakRefCollectionsTests
//
//  Created by Jan Nash on 12/8/16.
//  Copyright © 2016 JanNash. All rights reserved.
//

import XCTest
@testable import WeakRefCollections


class BaseTest: XCTestCase {
    // Here, we test the classes we use for testing
    func testFoo() {
        let _: Foo = Foo()
        // Nothing to test here, really...
        XCTAssert(true)
    }
    
    func testEquatableFooSameValueEqual() {
        let a: EquatableFoo = EquatableFoo(value: 1)
        let b: EquatableFoo = EquatableFoo(value: 1)
        
        XCTAssertTrue(a == b)
        XCTAssertFalse(a != b)
    }
    
    func testEquatableFooDifferentValuesNotEqual() {
        let a: EquatableFoo = EquatableFoo(value: 1)
        let b: EquatableFoo = EquatableFoo(value: 2)
        
        XCTAssertFalse(a == b)
        XCTAssertTrue(a != b)
    }
}
