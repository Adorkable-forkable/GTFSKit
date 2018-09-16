//
//  Route.swift
//  GTFSKit
//

import Foundation

public struct Route: Decodable {
    public let id: String           // route_id         (Required)
    public let agencyId: String?    // agency_id        (Optional)
    public let shortName: String    // route_short_name (Required)
    public let longName: String     // route_long_name  (Required)
    public let desc: String?        // route_desc       (Optional)
    public let type: RouteType      // route_type       (Required)
    public let url: String?         // route_url        (Optional)
    public let color: String?       // route_color      (Optional)
    public let textColor: String?   // route_text_color (Optional)

    enum CodingKeys : String, CodingKey {
        case id = "route_id"
        case agencyId = "agency_id"
        case shortName = "route_short_name"
        case longName = "route_long_name"
        case desc = "route_desc"
        case type = "route_type"
        case url = "route_url"
        case color = "route_color"
        case textColor = "route_text_color"
    }
}

extension Route {
    public class NoAgencyError: Error {
    }
    
    public func agency(_ agencies: [Agency]) throws -> Agency {
        guard let agencyId = self.agencyId else {
            throw NoAgencyError()
        }
        return try agencies.filterOne({ (agency) -> Bool in
            return agency.id == agencyId
        })
    }
    
    public func trips(_ trips: [Trip]) -> [Trip] {
        return trips.filter( { $0.routeId == self.id })
    }
    
    public func trips(_ trips: [Trip], inDirection direction: Direction) -> [Trip] {
        return self.trips(trips).filter({ (test) -> Bool in
            guard let testDirection = test.direction else {
                return false
            }
            return testDirection == direction
        })
    }
}

extension Array where Element == Route {
    public func routes(for agency: Agency) throws -> [Route] {
        return try agency.routes(self)
    }
    
    public func route(for trip: Trip) throws -> Route {
        return try trip.route(self)
    }
}
