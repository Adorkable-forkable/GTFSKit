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
    
    private func createLeft() -> Agency {
        return Agency(id: "hi", name: "name", url: "url", timezone: "EST", lang: nil, phone: nil, fareUrl: nil)
    }
}

extension AgencyTests {
    private func createRight() -> Agency {
        return Agency(id: nil, name: "name", url: "url", timezone: "EST", lang: nil, phone: nil, fareUrl: nil)
    }
    
    func testEquatable() {
        XCTAssertEqual(self.createLeft(), self.createLeft())
        XCTAssertNotEqual(self.createLeft(), self.createRight())
        XCTAssertNotEqual(self.createRight(), self.createRight())
    }
    
    func testComparable() {
        XCTAssertTrue(self.createLeft().compare(with: self.createLeft()))
        XCTAssertFalse(self.createLeft().compare(with: self.createRight()))
        
        let leftButDiffId = Agency(
            id: "ih",
            name: self.createLeft().name,
            url: self.createLeft().url,
            timezone: self.createLeft().timezone,
            lang: self.createLeft().lang,
            phone: self.createLeft().phone,
            fareUrl: self.createLeft().fareUrl)
        XCTAssertFalse(self.createLeft().compare(with: leftButDiffId))
    }
}

extension AgencyTests {
    func testCodable() {
        let leftEncoded: Data
        do {
            leftEncoded = try JSONEncoder().encode(self.createLeft())
        } catch {
            XCTFail("Encode threw: \(error)")
            return
        }
        
        let leftDecoded: Agency
        do {
            leftDecoded = try JSONDecoder().decode(Agency.self, from: leftEncoded)
        } catch {
            XCTFail("Decode threw: \(error)")
            return
        }

        XCTAssertEqual(self.createLeft(), leftDecoded)
    }
}
