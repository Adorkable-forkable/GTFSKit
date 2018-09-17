//
//  Trip.swift
//  GTFSKit
//

import Foundation

public struct Trip: Codable {
    public let id: String                           // trip_id                  (Required)
    public let routeId: String                      // route_id                 (Required)
    public let serviceId: String                    // service_id               (Required)
    public let headsign: String?                    // trip_headsign            (Optional)
    public let shortName: String?                   // trip_short_name          (Optional)
    public let direction: Direction?                // direction_id             (Optional)
    public let blockId: String?                     // block_id                 (Optional)
    public let shapeId: String?                     // shape_id                 (Optional)
    public let wheelchairAccessible: Accessibility? // wheelchair_accessible    (Optional)
    public let bikesAllowed: Accessibility?         // bikes_allowed            (Optional)
    
    public init(id: String, routeId: String, serviceId: String, headsign: String?, shortName: String?, direction: Direction?, blockId: String?, shapeId: String?, wheelchairAccessible: Accessibility?, bikesAllowed: Accessibility?) {
        self.id = id
        self.routeId = routeId
        self.serviceId = serviceId
        self.headsign = headsign
        self.shortName = shortName
        self.direction = direction
        self.blockId = blockId
        self.shapeId = shapeId
        self.wheelchairAccessible = wheelchairAccessible
        self.bikesAllowed = bikesAllowed
    }

    enum CodingKeys : String, CodingKey {
        case id = "trip_id"
        case routeId = "route_id"
        case serviceId = "service_id"
        case headsign = "trip_headsign"
        case shortName = "trip_short_name"
        case direction = "direction_id"
        case blockId = "block_id"
        case shapeId = "shape_id"
        case wheelchairAccessible = "wheelchair_accessible"
        case bikesAllowed = "bikes_allowed"
    }
}

extension Trip {
    public func stopTimes(_ stopTimes: [StopTime]) -> [StopTime] {
        return stopTimes.filter( { $0.tripId == self.id })
    }
    
    public func route(_ routes: [Route]) throws -> Route {
        return try routes.filterOne({ (route) -> Bool in
            return route.id == self.routeId
        })
    }
    
    class NoShapeIdError: Error {
    }
    public func shapes(_ shapes: [Shape]) throws -> [Shape] {
        guard let shapeId = self.shapeId else {
            throw NoShapeIdError()
        }
        return shapes.filter({ (shape) -> Bool in
            return shape.id == shapeId
        }).sorted(by: Shape.sort)
    }
}

extension Trip: Equatable {
    public static func == (lhs: Trip, rhs: Trip) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Trip {
    public func compare(with: Trip) -> Bool {
        return self.id == with.id
            && self.routeId == with.routeId
            && self.serviceId == with.serviceId
            && self.headsign == with.headsign
            && self.shortName == with.shortName
            && self.direction == with.direction
            && self.blockId == with.blockId
            && self.shapeId == with.shapeId
            && self.wheelchairAccessible == with.wheelchairAccessible
            && self.bikesAllowed == with.bikesAllowed
    }
}

extension Array where Element == Trip {
    public func trips(for route: Route) -> [Trip] {
        return route.trips(self)
    }
    
    public func trips(for route: Route, in direction: Direction) -> [Trip] {
        return route.trips(self, inDirection: direction)
    }
}
