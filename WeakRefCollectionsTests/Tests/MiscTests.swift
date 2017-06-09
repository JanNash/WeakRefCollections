//
//  MiscTests.swift
//  WeakRefCollections
//
//  Created by Jan Nash on 6/9/17.
//  Copyright © 2017 JanNash. All rights reserved.
//

import XCTest
@testable import WeakRefCollections


class MiscTests: BaseTest {
    func testShortDescriptionForNilOptional() {
        let foo: AnyObject? = nil
        let shortDesc: String = shortDescription(of: foo)
        XCTAssertEqual(shortDesc, "nil")
    }
}
