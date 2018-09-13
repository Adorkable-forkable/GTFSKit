//
//  CalendarDateTests.swift
//  GTFSKitTests
//
//  Created by Ian Grossberg on 9/10/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import XCTest
import GTFSKit

class CalendarDateTests: XCTestCase {
    func testParse() {
        guard let values: [CalendarDate] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "calendar_dates", withExtension: "txt") else {
            return
        }
        
        XCTAssertEqual(values.count, 96, "Expected 96 calendar dates")
    }
    
    func testCalendar() {
        guard let values: [CalendarDate] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "calendar_dates", withExtension: "txt") else {
            return
        }

        guard let calendars: [GTFSKit.Calendar] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "calendar", withExtension: "txt") else {
            return
        }

        for calendarDate in values {
            XCTAssertNoThrow(try calendarDate.calendar(calendars))
        }
    }
}
