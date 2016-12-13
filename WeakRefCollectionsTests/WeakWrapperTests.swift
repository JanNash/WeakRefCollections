//
//  WeakWrapperTests.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 12/12/16.
//  Copyright © 2016 JanNash. All rights reserved.
//

import XCTest
@testable import WeakRefCollections


class WeakWrapperTests: WRCMetaTest {
    class Foo {}
    
    func testValueIsStoredWeakly1() {
        let weak: WeakWrapper_<Foo> = WeakWrapper_(Foo())
        XCTAssert(weak.value == nil)
    }
    
    func testValueIsStoredWeakly2() {
        var foo: Foo? = Foo()
        let weak2: WeakWrapper_<Foo> = WeakWrapper_(foo!)
        XCTAssert(weak2.value != nil)
        foo = nil
        XCTAssert(weak2.value == nil)
    }
}
