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
