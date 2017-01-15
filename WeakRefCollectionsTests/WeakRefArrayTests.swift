//
//  WeakRefArrayTests.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 1/15/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

import XCTest
@testable import WeakRefCollections


extension WeakRefArrayTests.Foo: CustomStringConvertible {
    var description: String {
        return "<Foo value: \(self.value)>"
    }
}


class WeakRefArrayTests: WRCMetaTest {
    class Foo {
        init(_ value: String) {
            self.value = value
        }
        
        var value: String
    }
    
    func testSomething() {
        let a: Foo = Foo("a")
        let b: Foo = Foo("b")
        let c: Foo = Foo("c")
        var d: Foo = Foo("d")
        var e: Foo = Foo("e")
        
        let ary: WeakRefArray<Foo> = [a, b, c, d, e]
        
        print(ary)
//        debugPrint(ary)
        
        d = Foo("")
        e = Foo("")
        
        print(ary)
//        debugPrint(ary)

    }
}
