//
//  StopTests.swift
//  NYMTAKitTests
//
//  Created by Ian Grossberg on 9/10/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import XCTest
import GTFSKit

class StopTests: XCTestCase {
    func testParse() {
        guard let stops: [Stop] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "stops", withExtension: "txt") else {
            return
        }
        
        XCTAssertEqual(stops.count, 1503, "Expected 1503 stops")
    }
}

extension StopTests {
    private func createLeft() -> Stop {
        return Stop(id: "left", code: nil, name: "left", desc: "left", latitude: 1, longitude: 1, zoneId: nil, url: nil, locationType: nil, parentStation: nil, stopTimezone: nil, wheelchairBoarding: nil)
    }
    
    private func createRight() -> Stop {
        return Stop(id: "right", code: nil, name: "left", desc: "left", latitude: 1, longitude: 1, zoneId: nil, url: nil, locationType: nil, parentStation: nil, stopTimezone: nil, wheelchairBoarding: nil)
    }
    
    func testEquatable() {
        XCTAssertEqual(self.createLeft(), self.createLeft())
        XCTAssertNotEqual(self.createLeft(), self.createRight())
        XCTAssertEqual(self.createRight(), self.createRight())
    }
    
    func testCompare() {
        XCTAssertTrue(self.createLeft().compare(with: self.createLeft()))
        XCTAssertFalse(self.createLeft().compare(with: self.createRight()))
        
        let leftButDiffId = Stop(
            id: "ih",
            code: self.createLeft().code,
            name: self.createLeft().name,
            desc: self.createLeft().desc,
            latitude: self.createLeft().latitude,
            longitude: self.createLeft().longitude,
            zoneId: self.createLeft().zoneId,
            url: self.createLeft().url,
            locationType: self.createLeft().locationType,
            parentStation: self.createLeft().parentStation,
            stopTimezone: self.createLeft().stopTimezone,
            wheelchairBoarding: self.createLeft().wheelchairBoarding)
        XCTAssertFalse(self.createLeft().compare(with: leftButDiffId))
    }
    
    func testCodable() {
        let leftEncoded: Data
        do {
            leftEncoded = try JSONEncoder().encode(self.createLeft())
        } catch {
            XCTFail("Encode threw: \(error)")
            return
        }
        
        let leftDecoded: Stop
        do {
            leftDecoded = try JSONDecoder().decode(Stop.self, from: leftEncoded)
        } catch {
            XCTFail("Decode threw: \(error)")
            return
        }
        
        XCTAssertEqual(self.createLeft(), leftDecoded)
    }
}
