//
//  StopTime.swift
//  GTFSKit
//

import Foundation

public struct StopTime: Codable {
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

    public init(tripId: String, arrivalTime: Date?, departureTime: Date?, stopId: String, stopSequence: Int, stopHeadsign: String?, pickupType: BoardingType?, dropOffType: BoardingType?, shapeDistTraveled: String?, timepoint: Timepoint?) {
        self.tripId = tripId
        self.arrivalTime = arrivalTime
        self.departureTime = departureTime
        self.stopId = stopId
        self.stopSequence = stopSequence
        self.stopHeadsign = stopHeadsign
        self.pickupType = pickupType
        self.dropOffType = dropOffType
        self.shapeDistTraveled = shapeDistTraveled
        self.timepoint = timepoint
    }
    
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
    
    private static func decodeIfPresent(from container: KeyedDecodingContainer<StopTime.CodingKeys>, forKey key: CodingKeys) throws -> Date? {
        guard container.contains(key) else {
            return nil
        }
        guard let stringValue = try container.decodeIfPresent(String.self, forKey: key) else {
            return nil
        }

        var timeComponents = stringValue.split(separator: ":").map ({ Int($0) }).compactMap({ $0 })
        guard timeComponents.count == 3 else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [key], debugDescription: "Invalid time format, expected 'HH:mm:ss', received value '\(stringValue)'"))
        }

        return Date(timeInterval: TimeInterval(timeComponents[2] + timeComponents[1] * 60 + timeComponents[0] * 60 * 60), since: StopTime.timeSince)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tripId = try container.decode(String.self, forKey: .tripId)

        self.arrivalTime = try StopTime.decodeIfPresent(from: container, forKey: .arrivalTime)
        self.departureTime = try StopTime.decodeIfPresent(from: container, forKey: .departureTime)

        self.stopId = try container.decode(String.self, forKey: .stopId)
        self.stopSequence = try container.decode(Int.self, forKey: .stopSequence)
        self.stopHeadsign = try container.decodeIfPresent(String.self, forKey: .stopHeadsign)

        self.pickupType = try container.decodeIfPresent(BoardingType.self, forKey: .pickupType)

        self.dropOffType = try container.decodeIfPresent(BoardingType.self, forKey: .dropOffType)

        self.shapeDistTraveled = try container.decodeIfPresent(String.self, forKey: .shapeDistTraveled)
        
        self.timepoint = try container.decodeIfPresent(Timepoint.self, forKey: .timepoint)
    }
    
    private static func encodeIfPresent(from container: inout KeyedEncodingContainer<StopTime.CodingKeys>, value: Date?, forKey key: CodingKeys) throws {
        guard let value = value else {
            do {
                try container.encodeNil(forKey: key)
            } catch {} // We're ok if we can't encode nil
            return
        }
        
        let secondsSince = value.timeIntervalSince(StopTime.timeSince)
        var wholeSecondsSince = Int(secondsSince)

        let secondsPerHour = 60 * 60
        let hoursSince = wholeSecondsSince % secondsPerHour
        wholeSecondsSince -= hoursSince * secondsPerHour
        
        let secondsPerMinute = 60
        let minutesSince = wholeSecondsSince % secondsPerMinute
        wholeSecondsSince -= minutesSince * secondsPerMinute
        
        let result = String(format: "%02d:%02d:%02d", hoursSince, minutesSince, wholeSecondsSince)
        try container.encode(result, forKey: key)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.tripId, forKey: .tripId)
        
        try StopTime.encodeIfPresent(from: &container, value: self.arrivalTime, forKey: .arrivalTime)
        try StopTime.encodeIfPresent(from: &container, value: self.departureTime, forKey: .departureTime)

        try container.encode(self.stopId, forKey: .stopId)
        try container.encode(self.stopSequence, forKey: .stopSequence)
        try container.encodeIfPresent(self.stopHeadsign, forKey: .stopHeadsign)
        
        try container.encodeIfPresent(self.pickupType, forKey: .pickupType)

        try container.encodeIfPresent(self.dropOffType, forKey: .dropOffType)

        try container.encodeIfPresent(self.shapeDistTraveled, forKey: .shapeDistTraveled)

        try container.encodeIfPresent(self.timepoint, forKey: .timepoint)
    }
}

extension StopTime {
    public func stop(_ stops: [Stop]) throws -> Stop {
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

extension StopTime: Equatable {
    public static func == (lhs: StopTime, rhs: StopTime) -> Bool {
        return lhs.tripId == rhs.tripId
            && lhs.arrivalTime == rhs.arrivalTime
            && lhs.departureTime == rhs.departureTime
            && lhs.stopId == rhs.stopId
            && lhs.stopSequence == rhs.stopSequence
            && lhs.stopHeadsign == rhs.stopHeadsign
            && lhs.pickupType == rhs.pickupType
            && lhs.dropOffType == rhs.dropOffType
            && lhs.shapeDistTraveled == rhs.shapeDistTraveled
            && lhs.timepoint == rhs.timepoint
    }
}



extension Array where Element == StopTime {
    public func stopTimes(for trip: Trip) -> [StopTime] {
        return trip.stopTimes(self)
    }
}
