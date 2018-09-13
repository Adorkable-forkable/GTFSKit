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
