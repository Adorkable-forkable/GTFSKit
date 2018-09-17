//
//  TransferTests.swift
//  GTFSKitTests
//
//  Created by Ian Grossberg on 9/11/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import XCTest
import GTFSKit

class TransferTests: XCTestCase {
    func testParse() {
        testFromCSV(bundle: Bundle(for: type(of: self)), forResource: "transfers", withExtension: "txt", as: Transfer.self, expectedCount: 616)
    }
}

extension TransferTests {
    private func createLeft() -> Transfer {
        return Transfer(fromStopId: "1", toStopId: "2", transferType: .minimum, minTransferTime: nil)
    }
    
    private func createRight() -> Transfer {
        return Transfer(fromStopId: "1", toStopId: "2", transferType: .recommended, minTransferTime: nil)
    }
    
    func testEquatable() {
        XCTAssertEqual(self.createLeft(), self.createLeft())
        XCTAssertNotEqual(self.createLeft(), self.createRight())
        XCTAssertEqual(self.createRight(), self.createRight())
    }
}

extension TransferTests {
    func testCodable() {
        let leftEncoded: Data
        do {
            leftEncoded = try JSONEncoder().encode(self.createLeft())
        } catch {
            XCTFail("Encode threw: \(error)")
            return
        }
        
        let leftDecoded: Transfer
        do {
            leftDecoded = try JSONDecoder().decode(Transfer.self, from: leftEncoded)
        } catch {
            XCTFail("Decode threw: \(error)")
            return
        }
        
        XCTAssertEqual(self.createLeft(), leftDecoded)
    }
}
