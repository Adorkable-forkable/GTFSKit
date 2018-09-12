//
//  StopsTests.swift
//  NYMTAKitTests
//
//  Created by Ian Grossberg on 9/10/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import XCTest
import GTFSKit

class StopsTests: XCTestCase {
    func testParse() {
        guard let stops: [Stop] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "stops", withExtension: "txt") else {
            return
        }
        
        XCTAssertEqual(stops.count, 1503, "Expected 1503 stops")
    }
}
