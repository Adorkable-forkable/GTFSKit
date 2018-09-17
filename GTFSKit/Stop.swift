//
//  Stop.swift
//  GTFSKit
//

import Foundation
import CoreLocation

public struct Stop: Codable {
    public let id: String                           // stop_id              (Required)
    public let code: String?                        // stop_code            (Optional)
    public let name: String                         // stop_name            (Required)
    public let desc: String?                        // stop_desc            (Optional)
    public let latitude: CLLocationDegrees                 // stop_lat             (Required)
    public let longitude: CLLocationDegrees                // stop_lon             (Required)
    public var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    public let zoneId: String?                      // zone_id              (Optional)
    public let url: String?                         // stop_url             (Optional)
    public let locationType: LocationType?          // location_type        (Optional)
    public let parentStation: String?               // parent_station       (Optional)
    public let stopTimezone: String?                // stop_timezone        (Optional)
    public let wheelchairBoarding: Accessibility?   // wheelchair_boarding  (Optional)

    public init(id: String, code: String?, name: String, desc: String?, latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoneId: String?, url: String?, locationType: LocationType?, parentStation: String?, stopTimezone: String?, wheelchairBoarding: Accessibility?) {
        self.id = id
        self.code = code
        self.name = name
        self.desc = desc
        self.latitude = latitude
        self.longitude = longitude
        self.zoneId = zoneId
        self.url = url
        self.locationType = locationType
        self.parentStation = parentStation
        self.stopTimezone = stopTimezone
        self.wheelchairBoarding = wheelchairBoarding
    }
    
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

extension Stop: Equatable {
    public static func == (lhs: Stop, rhs: Stop) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Stop {
    public func compare(with: Stop) -> Bool {
        return self.id == with.id
            && self.code == with.code
            && self.name == with.name
            && self.desc == with.desc
            && self.latitude == with.latitude
            && self.longitude == with.longitude
            && self.zoneId == with.zoneId
            && self.url == with.url
            && self.locationType == with.locationType
            && self.parentStation == with.parentStation
            && self.stopTimezone == with.stopTimezone
            && self.wheelchairBoarding == with.wheelchairBoarding
    }
}

extension Array where Element == Stop {
    public func stop(for stopTime: StopTime) throws -> Stop {
        return try stopTime.stop(self)
    }
    
    public func fromStop(for transfer: Transfer) throws -> Stop {
        return try transfer.fromStop(self)
    }
    
    public func toStop(for transfer: Transfer) throws -> Stop {
        return try transfer.toStop(self)
    }
}
