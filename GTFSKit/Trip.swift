//
//  Trip.swift
//  GTFSKit
//

import Foundation

public struct Trip: Decodable {
    public let routeId: String                      // route_id                 (Required)
    public let serviceId: String                    // service_id               (Required)
    public let id: String                           // trip_id                  (Required)
    public let headsign: String?                    // trip_headsign            (Optional)
    public let shortName: String?                   // trip_short_name          (Optional)
    public let direction: Direction?                // direction_id             (Optional)
    public let blockId: String?                     // block_id                 (Optional)
    public let shapeId: String?                     // shape_id                 (Optional)
    public let wheelchairAccessible: Accessibility? // wheelchair_accessible    (Optional)
    public let bikesAllowed: Accessibility?         // bikes_allowed            (Optional)

    enum CodingKeys : String, CodingKey {
        case routeId = "route_id"
        case serviceId = "service_id"
        case id = "trip_id"
        case headsign = "trip_headsign"
        case shortName = "trip_short_name"
        case direction = "direction_id"
        case blockId = "block_id"
        case shapeId = "shape_id"
        case wheelchairAccessible = "wheelchair_accessible"
        case bikesAllowed = "bikes_allowed"
    }
}
