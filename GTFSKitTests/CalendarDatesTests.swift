//
//  CalendarDatesTests.swift
//  GTFSKitTests
//
//  Created by Ian Grossberg on 9/10/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import XCTest
import GTFSKit

class CalendarDatesTests: XCTestCase {
    func testParse() {
        guard let stops: [CalendarDate] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "calendar_dates", withExtension: "txt") else {
            return
        }
        
        XCTAssertEqual(stops.count, 96, "Expected 96 calendar dates")
    }
}
