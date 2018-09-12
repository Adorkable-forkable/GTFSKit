//
//  Shared.swift
//  GTFSKitTests
//
//  Created by Ian Grossberg on 9/10/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import XCTest
import GTFSKit
import CSV

func data(bundle: Bundle, forResource fileName: String, withExtension: String) -> Data? {
    guard let url = bundle.url(forResource: fileName, withExtension: withExtension) else {
        XCTFail("Unable to find color data file '\(fileName)'")
        return nil
    }
    let data: Data
    do {
        data = try Data(contentsOf: url)
    } catch {
        XCTFail("Reading contents of URL \(url) threw error: \(error)")
        return nil
    }
    return data
}

func createCSV(bundle: Bundle, forResource fileName: String, withExtension: String) -> CSVReader? {
    guard let data = data(bundle: bundle, forResource: fileName, withExtension: withExtension) else {
        return nil
    }
    guard let string = String(data: data, encoding: .utf8) else {
        XCTFail("Unable to convert data '\(data)' into String from '\(fileName)'")
        return nil
    }
    let result: CSVReader
    do {
        result = try CSVReader(string: string, hasHeaderRow: true, trimFields: true)
    } catch {
        XCTFail("While constructing CSVReader from '\(fileName)': \(error)")
        return nil
    }
    return result
}

func createFromCSV<Type>(bundle: Bundle, forResource fileName: String, withExtension: String) -> [Type]? where Type: Decodable {
    guard let csv = createCSV(bundle: bundle, forResource: fileName, withExtension: withExtension) else {
        return nil
    }

    var result: [Type] = []
    do {
        while let read: Type = try csv.readRow() {
            result.append(read)
        }
    } catch {
        XCTFail("While parsing \(Type.self): \(error)")
        return nil
    }
    return result
}

func testFromCSV<Type>(bundle: Bundle, forResource fileName: String, withExtension: String, as type: Type.Type, expectedCount: Int) where Type: Decodable {
    
    guard let csv = createCSV(bundle: bundle, forResource: fileName, withExtension: withExtension) else {
        return
    }
    
    var count = 0
    do {
        while let _: Type = try csv.readRow() {
            count += 1
        }
    } catch {
        XCTFail("While parsing \(Type.self): \(error)")
        return
    }
    XCTAssertEqual(count, expectedCount, "Expected \(expectedCount) \(Type.self)")
}
