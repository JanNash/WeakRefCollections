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
    
    func testValueIsStoredWeakly1() {
        let weak: WeakWrapper_ = WeakWrapper_(value: Foo(), previous: nil, delegate: nil)
        XCTAssert(weak.value == nil)
    }
    
    func testValueIsStoredWeakly2() {
        var foo: Foo? = Foo()
        let weak2: WeakWrapper_ = WeakWrapper_(value: foo!, previous: nil, delegate: nil)
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
            func didDisconnect(weakWrapper: WeakWrapper_) {
                self.callback()
            }
            
            var callback: (() -> Void) = { fatalError() }
        }
        
        let del: Bar = Bar()
        del.callback = expectation.fulfill
        
        _ = WeakWrapper_(value: Foo(), previous: nil, delegate: del)
        
        self.waitForExpectations(timeout: 0.1)
    }
}
