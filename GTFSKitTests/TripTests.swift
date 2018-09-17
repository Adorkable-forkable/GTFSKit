//
//  TripTests.swift
//  GTFSKitTests
//
//  Created by Ian Grossberg on 9/11/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import XCTest
import GTFSKit

class TripTests: XCTestCase {
    func testParse() {
        testFromCSV(bundle: Bundle(for: type(of: self)), forResource: "trips", withExtension: "txt", as: Trip.self, expectedCount: 19890)
    }
}

extension TripTests {
    private func createLeft() -> Trip {
        return Trip(id: "left", routeId: "left", serviceId: "left", headsign: nil, shortName: nil, direction: nil, blockId: nil, shapeId: nil, wheelchairAccessible: nil, bikesAllowed: nil)
    }
    
    private func createRight() -> Trip {
        return Trip(id: "right", routeId: "right", serviceId: "right", headsign: nil, shortName: nil, direction: nil, blockId: nil, shapeId: nil, wheelchairAccessible: nil, bikesAllowed: nil)
    }
    
    func testEquatable() {
        XCTAssertEqual(self.createLeft(), self.createLeft())
        XCTAssertNotEqual(self.createLeft(), self.createRight())
        XCTAssertEqual(self.createRight(), self.createRight())
    }
    
    func testCompare() {
        XCTAssertTrue(self.createLeft().compare(with: self.createLeft()))
        XCTAssertFalse(self.createLeft().compare(with: self.createRight()))
        
        let leftButDiffId = Trip(id: "hi", routeId: self.createLeft().routeId, serviceId: self.createLeft().serviceId, headsign: self.createLeft().headsign, shortName: self.createLeft().shortName, direction: self.createLeft().direction, blockId: self.createLeft().blockId, shapeId: self.createLeft().shapeId, wheelchairAccessible: self.createLeft().wheelchairAccessible, bikesAllowed: self.createLeft().bikesAllowed)
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
        
        let leftDecoded: Trip
        do {
            leftDecoded = try JSONDecoder().decode(Trip.self, from: leftEncoded)
        } catch {
            XCTFail("Decode threw: \(error)")
            return
        }
        
        XCTAssertEqual(self.createLeft(), leftDecoded)
    }
}
