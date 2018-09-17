//
//  StopTimeTests.swift
//  GTFSKitTests
//
//  Created by Ian Grossberg on 9/11/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import XCTest
import GTFSKit

class StopTimeTests: XCTestCase {
    func testParse() {
        testFromCSV(bundle: Bundle(for: type(of: self)), forResource: "stop_times", withExtension: "txt", as: StopTime.self, expectedCount: 548744)
    }
}

extension StopTimeTests {
    private func createLeft() -> StopTime {
        return StopTime(tripId: "left", arrivalTime: nil, departureTime: nil, stopId: "left", stopSequence: 1, stopHeadsign: nil, pickupType: nil, dropOffType: nil, shapeDistTraveled: nil, timepoint: nil)
    }
    
    private func createRight() -> StopTime {
        return StopTime(tripId: "right", arrivalTime: nil, departureTime: nil, stopId: "right", stopSequence: 1, stopHeadsign: nil, pickupType: nil, dropOffType: nil, shapeDistTraveled: nil, timepoint: nil)
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
        
        let leftDecoded: StopTime
        do {
            leftDecoded = try JSONDecoder().decode(StopTime.self, from: leftEncoded)
        } catch {
            XCTFail("Decode threw: \(error)")
            return
        }
        
        XCTAssertEqual(self.createLeft(), leftDecoded)
    }
}
