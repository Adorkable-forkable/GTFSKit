//
//  RouteTests.swift
//  GTFSKitTests
//
//  Created by Ian Grossberg on 9/10/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import XCTest
import GTFSKit

class RouteTests: XCTestCase {
    func testParse() {
        guard let values: [Route] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "routes", withExtension: "txt") else {
            return
        }
        
        XCTAssertEqual(values.count, 29, "Expected 29 routes")
    }
}
