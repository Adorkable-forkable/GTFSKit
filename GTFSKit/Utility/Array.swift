//
//  Array.swift
//  GTFSKit
//
//  Created by Ian Grossberg on 9/13/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import Foundation

extension Array {
    open class NoMatchesFoundError: Error {
    }
    
    open class TooManyMatchesFoundError: Error {
    }
    
    func filterOne(_ isIncluded: (Element) throws -> Bool) throws -> Element {
        let found = try self.filter(isIncluded)
        
        guard found.count < 2 else {
            throw TooManyMatchesFoundError()
        }
        
        guard let result = found.first else {
            throw NoMatchesFoundError()
        }
        
        return result
    }
}
