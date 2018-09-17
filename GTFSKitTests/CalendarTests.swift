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
    
    func testCalendarDates() {
        guard let values: [GTFSKit.Calendar] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "calendar", withExtension: "txt") else {
            return
        }
        
        guard let calendarDates: [CalendarDate] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "calendar_dates", withExtension: "txt") else {
            return
        }
        
        for calendar in values {
            let calendarDatesForCalendar = calendar.calendarDates(calendarDates)
            XCTAssertGreaterThanOrEqual(calendarDatesForCalendar.count, 0)
        }

        let calendarDatesForCalendar23 = values[23].calendarDates(calendarDates)
        XCTAssertEqual(calendarDatesForCalendar23.count, 2)
    }
}

extension CalendarTests {
    private func createLeft() -> GTFSKit.Calendar {
        return GTFSKit.Calendar(serviceId: "1234", monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true, startDate: Date(timeIntervalSince1970: 0), endDate: Date(timeIntervalSince1970: 60 * 60 * 60))
    }
    
    private func createRight() -> GTFSKit.Calendar {
        return GTFSKit.Calendar(serviceId: "1234", monday: false, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true, startDate: Date(timeIntervalSince1970: 0), endDate: Date(timeIntervalSince1970: 60 * 60 * 60))
    }
    
    func testEquatable() {
        XCTAssertEqual(self.createLeft(), self.createLeft())
        XCTAssertNotEqual(self.createLeft(), self.createRight())
        XCTAssertEqual(self.createRight(), self.createRight())
    }
}

extension CalendarTests {
    func testCodable() {
        let leftEncoded: Data
        do {
            leftEncoded = try JSONEncoder().encode(self.createLeft())
        } catch {
            XCTFail("Encode threw: \(error)")
            return
        }
        
        let leftDecoded: GTFSKit.Calendar
        do {
            leftDecoded = try JSONDecoder().decode(GTFSKit.Calendar.self, from: leftEncoded)
        } catch {
            XCTFail("Decode threw: \(error)")
            return
        }
        
        XCTAssertEqual(self.createLeft(), leftDecoded)
    }
}
