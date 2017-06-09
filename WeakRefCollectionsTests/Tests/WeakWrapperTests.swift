//
//  WeakWrapperTests.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 12/12/16.
//  Copyright © 2016 JanNash. All rights reserved.
//

import XCTest
@testable import WeakRefCollections


class WeakWrapperTests: BaseTest {
    func testValueIsStoredWeakly1() {
        let weakWrapper: WeakWrapper_ = WeakWrapper_(value: Foo(), delegate: nil)
        XCTAssert(weakWrapper.value == nil)
    }
    
    func testValueIsStoredWeakly2() {
        var foo: Foo? = Foo()
        let weakWrapper: WeakWrapper_ = WeakWrapper_(value: foo!, delegate: nil)
        XCTAssert(weakWrapper.value != nil)
        foo = nil
        XCTAssert(weakWrapper.value == nil)
    }
    
    func testDeinitDelegateCallback() {
        // This implicitly tests the functionality of the DeinitBackCaller
        // TODO: Maybe an explicit test for it would also be nice...
        
        let expectation: XCTestExpectation = self.expectation(
            description: "Delegate was not called when value was deinitialized"
        )
        
        class Bar: WeakWrapperDelegate_ {
            func disconnected<Foo>(weakWrapper: WeakWrapper_<Foo>) {
                self.callback()
            }
            
            var callback: (() -> Void) = { fatalError() }
        }
        
        let del: Bar = Bar()
        del.callback = expectation.fulfill
        
        _ = WeakWrapper_(value: Foo(), delegate: del)
        
        self.waitForExpectations(timeout: 0.1)
    }
    
    func testValueIsNilInDeinitDelegateCallback() {
        let expectation: XCTestExpectation = self.expectation(
            description: "Delegate was not called when value was deinitialized"
        )
        
        class Bar: WeakWrapperDelegate_ {
            func disconnected<Foo>(weakWrapper: WeakWrapper_<Foo>) {
                XCTAssertNil(weakWrapper.value, "Value was not nil in deinit delegate callback")
                self.callback()
            }
            
            var callback: (() -> Void) = { fatalError() }
        }
        
        let del: Bar = Bar()
        del.callback = expectation.fulfill
        
        _ = WeakWrapper_(value: Foo(), delegate: del)
        
        self.waitForExpectations(timeout: 0.1)
    }
    
    func testEquatableEqualIfValueEqual() {
        let foo1: EquatableFoo = EquatableFoo(value: 1)
        let foo2: EquatableFoo = EquatableFoo(value: 1)
        
        let weak1: WeakWrapper_<EquatableFoo> = WeakWrapper_(value: foo1, delegate: nil)
        let weak2: WeakWrapper_<EquatableFoo> = WeakWrapper_(value: foo2, delegate: nil)
        
        XCTAssertTrue(weak1 == weak2)
        XCTAssertFalse(weak1 != weak2)
    }
    
    func testEquatableNotEqualIfValueNotEqual() {
        let foo1: EquatableFoo = EquatableFoo(value: 1)
        let foo2: EquatableFoo = EquatableFoo(value: 2)
        
        let weak1: WeakWrapper_<EquatableFoo> = WeakWrapper_(value: foo1, delegate: nil)
        let weak2: WeakWrapper_<EquatableFoo> = WeakWrapper_(value: foo2, delegate: nil)
        
        XCTAssertFalse(weak1 == weak2)
        XCTAssertTrue(weak1 != weak2)
    }
    
    func testDescription() {
        let description: String = WeakWrapper_(value: Foo(), delegate: nil).description
        XCTAssertFalse(description.isEmpty)
    }
    
    func testDebugDescription() {
        let debugDescription: String = WeakWrapper_(value: Foo(), delegate: nil).debugDescription
        XCTAssertFalse(debugDescription.isEmpty)
    }
}
