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
    func testInitialValueIsNil() {
        let weak: WeakWrapper_<NSObject> = WeakWrapper_()
        XCTAssert(weak.value == nil)
    }
}
