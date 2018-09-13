//
//  Agency.swift
//  GTFSKit
//

import Foundation

public class Agency: Decodable {
    public let id: String?                  // agency_id        (Optional)
    public let name: String                 // agency_name      (Required)
    public let url: String                  // agency_url       (Required)
    public let timezone: String             // agency_timezone  (Required)
    public let lang: String?                // agency_lang      (Optional)
    public let phone: String?               // agency_phone     (Optional)
    public let fareUrl: String?             // agency_fare_url  (Optional)

    enum CodingKeys: String, CodingKey {
        case id = "agency_id"
        case name = "agency_name"
        case url = "agency_url"
        case timezone = "agency_timezone"
        case lang = "agency_lang"
        case phone = "agency_phone"
        case fareUrl = "agency_fare_url"
    }
    
    public class NoIdError: Error {
    }
    public func routes(_ routes: [Route]) throws -> [Route] {
        guard let id = self.id else {
            throw NoIdError()
        }
        return routes.filter({ (route) -> Bool in
            return route.agencyId == id
        })
    }
}

extension Array where Element == Agency {
    public func agency(for route: Route) throws -> Agency {
        return try route.agency(self)
    }
}
