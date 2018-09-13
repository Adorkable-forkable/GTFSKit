//
//  Stop.swift
//  GTFSKit
//

import Foundation
import CoreLocation

public struct Stop: Decodable {
    public let id: String                           // stop_id              (Required)
    public let code: String?                        // stop_code            (Optional)
    public let name: String                         // stop_name            (Required)
    public let desc: String?                        // stop_desc            (Optional)
    let latitude: CLLocationDegrees                 // stop_lat             (Required)
    let longitude: CLLocationDegrees                // stop_lon             (Required)
    public var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    public let zoneId: String?                      // zone_id              (Optional)
    public let url: String?                         // stop_url             (Optional)
    public let locationType: LocationType?          // location_type        (Optional)
    public let parentStation: String?               // parent_station       (Optional)
    public let stopTimezone: String?                // stop_timezone        (Optional)
    public let wheelchairBoarding: Accessibility?   // wheelchair_boarding  (Optional)

    enum CodingKeys : String, CodingKey {
        case id = "stop_id"
        case code = "stop_code"
        case name = "stop_name"
        case desc = "stop_desc"
        case latitude = "stop_lat"
        case longitude = "stop_lon"
        case zoneId = "zone_id"
        case url = "stop_url"
        case locationType = "location_type"
        case parentStation = "parent_station"
        case stopTimezone = "stop_timezone"
        case wheelchairBoarding = "wheelchair_boarding"
    }
}

extension Stop {
    public func stopTimes(_ stopTimes: [StopTime]) -> [StopTime] {
        return stopTimes.filter({ (stopTime) -> Bool in
            return stopTime.stopId == self.id
        })
    }
}

extension Array where Element == Stop {
    public func stop(for stopTime: StopTime) throws -> Stop {
        return try stopTime.stop(stops: self)
    }
    
    public func fromStop(for transfer: Transfer) throws -> Stop {
        return try transfer.fromStop(stops: self)
    }
    
    public func toStop(for transfer: Transfer) throws -> Stop {
        return try transfer.toStop(stops: self)
    }
}
