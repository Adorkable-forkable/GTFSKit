//
//  Trip.swift
//  GTFSKit
//
//  Created by Jack Wilsdon on 06/10/2015.
//  Copyright © 2015 Jack Wilsdon. All rights reserved.
//

import Foundation

public struct Trip: CSVParsable {
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

    public init(routeId: String, serviceId: String, id: String, headsign: String?, shortName: String?, direction: Direction?, blockId: String?, shapeId: String?, wheelchairAccessible: Accessibility?, bikesAllowed: Accessibility?) {
        self.routeId = routeId
        self.serviceId = serviceId
        self.id = id
        self.headsign = headsign
        self.shortName = shortName
        self.direction = direction
        self.blockId = blockId
        self.shapeId = shapeId
        self.wheelchairAccessible = wheelchairAccessible
        self.bikesAllowed = bikesAllowed
    }

    public static func parse(data: CSVData) -> Trip? {
        if !data.containsColumns("route_id", "service_id", "trip_id") {
            return nil
        }

        let routeId = data["route_id"]!
        let serviceId = data["service_id"]!
        let id = data["trip_id"]!
        let headsign = data["trip_headsign"]
        let shortName = data["trip_short_name"]

        var direction: Direction? = nil

        if let directionString = data["direction_id"] {
            if let directionValue = Int(directionString) {
                direction = Direction(rawValue: directionValue)
            }
        }

        let blockId = data["block_id"]
        let shapeId = data["shape_id"]

        var wheelchairAccessible: Accessibility? = nil

        if let wheelchairAccessibleString = data["wheelchair_accessible"] {
            if let wheelchairAccessibleValue = Int(wheelchairAccessibleString) {
                wheelchairAccessible = Accessibility(rawValue: wheelchairAccessibleValue)
            }
        }

        var bikesAllowed: Accessibility? = nil

        if let bikesAllowedString = data["bikes_allowed"] {
            if let bikesAllowedValue = Int(bikesAllowedString) {
                bikesAllowed = Accessibility(rawValue: bikesAllowedValue)
            }
        }

        return Trip(routeId: routeId, serviceId: serviceId, id: id, headsign: headsign, shortName: shortName, direction: direction, blockId: blockId, shapeId: shapeId, wheelchairAccessible: wheelchairAccessible, bikesAllowed: bikesAllowed)
    }
    
}