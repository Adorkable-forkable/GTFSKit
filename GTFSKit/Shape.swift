//
//  Shape.swift
//  GTFSKit
//
//  Created by Ian Grossberg on 9/13/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import Foundation
import CoreLocation

public struct Shape: Codable {
    public let id: String                                   // shape_id (Required)
    
    public let latitude: CLLocationDegrees                             // shape_pt_lat (Required)
    public let longitude: CLLocationDegrees                            // shape_pt_lon (Required)
    public var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    public let sequence: Int                                // shape_pt_sequence (Required)

    public let distanceTraveled: Double?                     // shape_dist_traveled (Optional)
    
    public init(id: String, latitude: Double, longitude: Double, sequence: Int, distanceTraveled: Double?) {
        self.id = id
        
        self.latitude = latitude
        self.longitude = longitude
        
        self.sequence = sequence
        
        self.distanceTraveled = distanceTraveled
    }
    
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

extension Shape: Equatable {
    public static func == (lhs: Shape, rhs: Shape) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Shape {
    public func compare(with: Shape) -> Bool {
        return self.id == with.id
            && self.latitude == with.latitude
            && self.longitude == with.longitude
            && self.sequence == with.sequence
            && self.distanceTraveled == with.distanceTraveled
    }
}

extension Array where Element == Shape {
    public func shapes(for trip: Trip) throws -> [Shape] {
        return try trip.shapes(self)
    }
}
