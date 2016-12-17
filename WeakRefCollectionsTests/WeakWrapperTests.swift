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
    
    func testDeinitDelegateCallback() {
        // This implicitly tests the functionality of the DeinitBackCaller
        // TODO: Maybe an explicit test for it would also be nice...
        
        let expectation: XCTestExpectation = self.expectation(
            description: "Delegate was not called when value was deinitialized"
        )
        
        class Bar: WeakWrapperDelegate_ {
            func valueDeinitialized<T: AnyObject>(of weakWrapper: WeakWrapper_<T>) {
                self.callback()
            }
            
            var callback: (() -> Void) = { fatalError() }
        }
        
        let del: Bar = Bar()
        del.callback = expectation.fulfill
        
        _ = WeakWrapper_(Foo(), delegate: del)
        
        self.waitForExpectations(timeout: 0.1)
    }
}
