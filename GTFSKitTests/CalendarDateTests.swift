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

extension CalendarDateTests {
    private func createLeft() -> CalendarDate {
        return CalendarDate(serviceId: "1234", date: Date(timeIntervalSince1970: 0), exceptionType: .added)
    }
    
    private func createRight() -> CalendarDate {
        return CalendarDate(serviceId: "1234", date: Date(timeIntervalSince1970: 0), exceptionType: .removed)
    }
    
    func testEquatable() {
        XCTAssertEqual(self.createLeft(), self.createLeft())
        XCTAssertNotEqual(self.createLeft(), self.createRight())
        XCTAssertEqual(self.createRight(), self.createRight())
    }
    
    func testCodable() {
        let leftEncoded: Data
        do {
            leftEncoded = try JSONEncoder().encode(self.createLeft())
        } catch {
            XCTFail("Encode threw: \(error)")
            return
        }
        
        let leftDecoded: CalendarDate
        do {
            leftDecoded = try JSONDecoder().decode(CalendarDate.self, from: leftEncoded)
        } catch {
            XCTFail("Decode threw: \(error)")
            return
        }
        
        XCTAssertEqual(self.createLeft(), leftDecoded)
    }
}
