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
    
    func testTrips() {
        guard let values: [Route] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "routes", withExtension: "txt") else {
            return
        }
        
        guard let trips: [Trip] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "trips", withExtension: "txt") else {
            return
        }
        
        for route in values {
            XCTAssertGreaterThan(route.trips(trips).count, 0)
        }
    }
    
    func testTripsInDirection() {
        guard let values: [Route] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "routes", withExtension: "txt") else {
            return
        }
        
        guard let trips: [Trip] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "trips", withExtension: "txt") else {
            return
        }
        
        for route in values {
            XCTAssertGreaterThan(route.trips(trips, inDirection: .forward).count, 0)
            XCTAssertGreaterThanOrEqual(route.trips(trips, inDirection: .backward).count, 0)
        }
    }
}

extension RouteTests {
    private func createLeft() -> Route {
        return Route(id: "left", agencyId: nil, shortName: "short", longName: "long", desc: nil, type: .bus, url: nil, color: nil, textColor: nil)
    }
    
    private func createRight() -> Route {
        return Route(id: "right", agencyId: nil, shortName: "short", longName: "long", desc: nil, type: .bus, url: nil, color: nil, textColor: nil)
    }
    
    func testEquatable() {
        XCTAssertEqual(self.createLeft(), self.createLeft())
        XCTAssertNotEqual(self.createLeft(), self.createRight())
        XCTAssertEqual(self.createRight(), self.createRight())
    }
    
    func testCompare() {
        XCTAssertTrue(self.createLeft().compare(with: self.createLeft()))
        XCTAssertFalse(self.createLeft().compare(with: self.createRight()))
        
        let leftButDiffId = Route(
            id: "ih",
            agencyId: self.createLeft().agencyId,
            shortName: self.createLeft().shortName,
            longName: self.createLeft().longName,
            desc: self.createLeft().desc,
            type: self.createLeft().type,
            url: self.createLeft().url,
            color: self.createLeft().color,
            textColor: self.createLeft().textColor)
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
        
        let leftDecoded: Route
        do {
            leftDecoded = try JSONDecoder().decode(Route.self, from: leftEncoded)
        } catch {
            XCTFail("Decode threw: \(error)")
            return
        }
        
        XCTAssertEqual(self.createLeft(), leftDecoded)
    }
}
