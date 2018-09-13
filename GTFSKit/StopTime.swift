//
//  StopTime.swift
//  GTFSKit
//

import Foundation

public struct StopTime: Decodable {
    public let tripId: String                       // trip_id                  (Required)
    
    // TODO: access func that requires Date so we clarify that arrivalTime and departureTime are times without dates
    public let arrivalTime: Date?                    // arrival_time             (Optional) - TODO: Actually required but can be empty
    public let departureTime: Date?                  // departure_time           (Optional) - TODO: Actually required but can be empty

    public let stopId: String                       // stop_id                  (Required)
    public let stopSequence: Int                    // stop_sequence            (Required)
    public let stopHeadsign: String?                // stop_headsign            (Optional)
    public let pickupType: BoardingType?            // pickup_type              (Optional)
    public let dropOffType: BoardingType?           // drop_off_type            (Optional)
    public let shapeDistTraveled: String?           // shape_dist_traveled      (Optional)
    public let timepoint: Timepoint?                // timepoint                (Optional)

    enum CodingKeys : String, CodingKey {
        case tripId = "trip_id"
        case arrivalTime = "arrival_time"
        case departureTime = "departure_time"
        case stopId = "stop_id"
        case stopSequence = "stop_sequence"
        case stopHeadsign = "stop_headsign"
        case pickupType = "pickup_type"
        case dropOffType = "drop_off_type"
        case shapeDistTraveled = "shape_dist_traveled"
        case timepoint = "timepoint"
    }
    
    static let timeSince = Date(timeIntervalSince1970: 0)
    
    private static func decode(from container: KeyedDecodingContainer<StopTime.CodingKeys>, forKey key: CodingKeys) throws -> Date {
        let stringValue = try container.decode(String.self, forKey: key)

        var timeComponents = stringValue.split(separator: ":").map ({ Int($0) }).compactMap({ $0 })
        guard timeComponents.count == 3 else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [key], debugDescription: "Invalid time format, expected 'HH:mm:ss', received value '\(stringValue)'"))
        }

        return Date(timeInterval: TimeInterval(timeComponents[2] + timeComponents[1] * 60 + timeComponents[0] * 60 * 60), since: StopTime.timeSince)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tripId = try container.decode(String.self, forKey: .tripId)
        if container.contains(.arrivalTime) {
            self.arrivalTime = try StopTime.decode(from: container, forKey: .arrivalTime)
        } else {
            self.arrivalTime = nil
        }
        if container.contains(.departureTime) {
            self.departureTime = try StopTime.decode(from: container, forKey: .departureTime)
        } else {
            self.departureTime = nil
        }
        self.stopId = try container.decode(String.self, forKey: .stopId)
        self.stopSequence = try container.decode(Int.self, forKey: .stopSequence)
        if container.contains(.stopHeadsign) {
            self.stopHeadsign = try container.decode(String.self, forKey: .stopHeadsign)
        } else {
            self.stopHeadsign = nil
        }
        if container.contains(.pickupType) {
            self.pickupType = try container.decode(BoardingType.self, forKey: .pickupType)
        } else {
            self.pickupType = nil
        }
        if container.contains(.dropOffType) {
            self.dropOffType = try container.decode(BoardingType.self, forKey: .dropOffType)
        } else {
            self.dropOffType = nil
        }
        if container.contains(.shapeDistTraveled) {
            self.shapeDistTraveled = try container.decode(String.self, forKey: .shapeDistTraveled)
        } else {
            self.shapeDistTraveled = nil
        }
        if container.contains(.timepoint) {
            self.timepoint = try container.decode(Timepoint.self, forKey: .timepoint)
        } else {
            self.timepoint = nil
        }
    }
}

extension StopTime {
    public func stop(stops: [Stop]) throws -> Stop {
        return try stops.filterOne({ (stop) -> Bool in
            return stop.id == self.stopId
        })
    }
    
    public func trip(_ trips: [Trip]) throws -> Trip {
        return try trips.filterOne({ (trip) -> Bool in
            return trip.id == self.tripId
        })
    }
    
    public static func sort(left: StopTime, right: StopTime) -> ComparisonResult {
        if left.stopSequence < right.stopSequence {
            return .orderedAscending
        } else if left.stopSequence == right.stopSequence {
            return .orderedSame
        } else {
            return .orderedDescending
        }
    }
    
    public static func sort(left: StopTime, right: StopTime) -> Bool {
        return self.sort(left: left, right: right) == .orderedAscending
    }
}

extension Array where Element == StopTime {
    public func stopTimes(for trip: Trip) -> [StopTime] {
        return trip.stopTimes(self)
    }
}
