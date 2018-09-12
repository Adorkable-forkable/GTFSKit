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
