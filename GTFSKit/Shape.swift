//
//  Shape.swift
//  GTFSKit
//
//  Created by Ian Grossberg on 9/13/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import Foundation
import CoreLocation

public struct Shape: Decodable {
    public let id: String                                   // shape_id (Required)
    
    public let latitude: Double                             // shape_pt_lat (Required)
    public let longitude: Double                            // shape_pt_lon (Required)
    public var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    public let sequence: Int                                // shape_pt_sequence (Required)

    public let distanceTraveled: Double?                     // shape_dist_traveled (Optional)
    
    enum CodingKeys : String, CodingKey {
        case id = "shape_id"
        case latitude = "shape_pt_lat"
        case longitude = "shape_pt_lon"
        case sequence = "shape_pt_sequence"
        case distanceTraveled = "shape_dist_traveled"
    }
}

extension Shape {
    public static func sort(left: Shape, right: Shape) -> ComparisonResult {
        if left.sequence < right.sequence {
            return .orderedAscending
        } else if left.sequence == right.sequence {
            return .orderedSame
        } else {
            return .orderedDescending
        }
    }
    
    public static func sort(left: Shape, right: Shape) -> Bool {
        return self.sort(left: left, right: right) == .orderedAscending
    }
}

extension Array where Element == Shape {
    public func shapes(for trip: Trip) throws -> [Shape] {
        return try trip.shapes(self)
    }
}
