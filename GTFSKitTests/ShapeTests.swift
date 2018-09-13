//
//  ShapeTests.swift
//  GTFSKitTests
//
//  Created by Ian Grossberg on 9/13/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import XCTest
import GTFSKit

class ShapeTests: XCTestCase {
    func testParse() {
        testFromCSV(bundle: Bundle(for: type(of: self)), forResource: "shapes", withExtension: "txt", as: Shape.self, expectedCount: 19890)
    }
}
