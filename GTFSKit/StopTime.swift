//
//  StopTime.swift
//  GTFSKit
//

import Foundation

public struct StopTime: CSVParsable {
    public let tripId: String                       // trip_id                  (Required)
    public let arrivalTime: Int?                    // arrival_time             (Optional) - Actually required but can be empty
    public let departureTime: Int?                  // departure_time           (Optional) - Actually required but can be empty
    public let stopId: String                       // stop_id                  (Required)
    public let stopSequence: Int                    // stop_sequence            (Required)
    public let stopHeadsign: String?                // stop_headsign            (Optional)
    public let pickupType: BoardingType?            // pickup_type              (Optional)
    public let dropOffType: BoardingType?           // drop_off_type            (Optional)
    public let shapeDistTraveled: String?           // shape_dist_traveled      (Optional)
    public let timepoint: Timepoint?                // timepoint                (Optional)

    public init(tripId: String, arrivalTime: Int?, departureTime: Int?, stopId: String, stopSequence: Int, stopHeadsign: String?, pickupType: BoardingType?, dropOffType: BoardingType?, shapeDistTraveled: String?, timepoint: Timepoint?) {
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

    public static func parse(data: CSVData) -> StopTime? {
        if !data.contains(columnNames: "trip_id", "arrival_time", "departure_time", "stop_id", "stop_sequence") {
            return nil
        }

        let tripId = data["trip_id"]!
        let arrivalTime = data.get(columnName: "arrival_time", parser: { Int($0) })
        let departureTime = data.get(columnName: "departure_time", parser: { Int($0) })
        let stopId = data["stop_id"]!

        guard let stopSequence = data.get(columnName: "stop_sequence", parser: { Int($0) }) else {
            return nil
        }

        let stopHeadsign = data["stop_headsign"]
        let pickupType = data.get(columnName: "pickup_type", parser: BoardingType.fromString(defaultValue: BoardingType.regular))
        let dropOffType = data.get(columnName: "drop_off_type", parser: BoardingType.fromString(defaultValue: BoardingType.regular))
        let shapeDistTraveled = data["shape_dist_traveled"]
        let timepoint = data.get(columnName: "timepoint", parser: Timepoint.fromString(defaultValue: Timepoint.exact))

        return StopTime(tripId: tripId, arrivalTime: arrivalTime, departureTime: departureTime, stopId: stopId, stopSequence: stopSequence, stopHeadsign: stopHeadsign, pickupType: pickupType, dropOffType: dropOffType, shapeDistTraveled: shapeDistTraveled, timepoint: timepoint)
    }

}
