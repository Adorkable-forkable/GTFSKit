//
//  CalendarTests.swift
//  GTFSKitTests
//
//  Created by Ian Grossberg on 9/10/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import XCTest
import GTFSKit

class CalendarTests: XCTestCase {
    func testParse() {
        guard let values: [GTFSKit.Calendar] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "calendar", withExtension: "txt") else {
            return
        }
        
        XCTAssertEqual(values.count, 73, "Expected 73 calendars")
    }
}