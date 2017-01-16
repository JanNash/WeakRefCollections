//
//  WeakRefArrayTests.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 1/15/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

import XCTest
@testable import WeakRefCollections


class WeakRefArrayTests: WRCMetaTest {
    func testSomething() {
        let a: Foo = Foo()
        let b: Foo = Foo()
        let c: Foo = Foo()
        var d: Foo = Foo()
        var e: Foo = Foo()
        
        let ary: WeakRefArray<Foo> = [a, b, c, d, e]
        
        print(ary)
        debugPrint(ary)
        
        d = Foo()
        e = Foo()
        
        print(ary)
        debugPrint(ary)

    }
}
