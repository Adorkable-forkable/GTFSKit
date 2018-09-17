//
//  KeyedDecodingContainer.swift
//  GTFSKit-iOS
//
//  Created by Ian Grossberg on 9/16/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    public func decode(_ type: Date.Type, forKey key: KeyedDecodingContainer.Key, formatter: DateFormatter) throws -> Date {
        let stringValue = try self.decode(String.self, forKey: key)
        
        guard let result = formatter.date(from: stringValue) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: [key],
                debugDescription: "Invalid time format, expected '\(Calendar.timeDateFormatter.dateFormat)', received value '\(stringValue)'")
            )
        }
        return result
    }
}
