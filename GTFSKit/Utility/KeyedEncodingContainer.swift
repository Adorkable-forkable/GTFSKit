//
//  KeyedEncodingContainer.swift
//  GTFSKit
//
//  Created by Ian Grossberg on 9/16/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import Foundation

extension KeyedEncodingContainer {
    public mutating func encode(_ value: Date, forKey key: KeyedEncodingContainer.Key, formatter: DateFormatter) throws {
        let stringValue = formatter.string(from: value)
        
        try self.encode(stringValue, forKey: key)
    }
}
