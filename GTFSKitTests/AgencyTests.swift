//
//  AgencyTests.swift
//  GTFSKitTests
//
//  Created by Ian Grossberg on 9/11/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import XCTest
import GTFSKit

class AgencyTests: XCTestCase {
    func testParse() {
        guard let values: [Agency] = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "agency", withExtension: "txt") else {
            return
        }
        
        XCTAssertEqual(values.count, 1, "Expected 1 agency")
    }
}
