//
//  ShapeTests.swift
//  GTFSKitTests
//
//  Created by Ian Grossberg on 9/13/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import XCTest
import GTFSKit

class ShapeTests: XCTestCase {
    func testParse() {
        testFromCSV(bundle: Bundle(for: type(of: self)), forResource: "shapes", withExtension: "txt", as: Shape.self, expectedCount: 124098)
    }
}

extension ShapeTests {
    private func createLeft() -> Shape {
        return Shape(id: "left", latitude: 1, longitude: 1, sequence: 1, distanceTraveled: nil)
    }
    
    private func createRight() -> Shape {
        return Shape(id: "right", latitude: 1, longitude: 1, sequence: 1, distanceTraveled: nil)
    }
    
    func testEquatable() {
        XCTAssertEqual(self.createLeft(), self.createLeft())
        XCTAssertNotEqual(self.createLeft(), self.createRight())
        XCTAssertEqual(self.createRight(), self.createRight())
    }
    
    func testCompare() {
        XCTAssertTrue(self.createLeft().compare(with: self.createLeft()))
        XCTAssertFalse(self.createLeft().compare(with: self.createRight()))
        
        let leftButDiffId = Shape(
            id: "ih",
            latitude: self.createLeft().latitude,
            longitude: self.createLeft().longitude,
            sequence: self.createLeft().sequence,
            distanceTraveled: self.createLeft().distanceTraveled)
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
        
        let leftDecoded: Shape
        do {
            leftDecoded = try JSONDecoder().decode(Shape.self, from: leftEncoded)
        } catch {
            XCTFail("Decode threw: \(error)")
            return
        }
        
        XCTAssertEqual(self.createLeft(), leftDecoded)
    }
}
