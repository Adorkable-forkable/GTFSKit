//
//  Agency.swift
//  GTFSKit
//

import Foundation

public class Agency: Codable {
    public let id: String?                  // agency_id        (Optional)
    public let name: String                 // agency_name      (Required)
    public let url: String                  // agency_url       (Required)
    public let timezone: String             // agency_timezone  (Required)
    public let lang: String?                // agency_lang      (Optional)
    public let phone: String?               // agency_phone     (Optional)
    public let fareUrl: String?             // agency_fare_url  (Optional)
    
    public init(id: String?, name: String, url: String, timezone: String, lang: String?, phone: String?, fareUrl: String?) {
        self.id = id
        self.name = name
        self.url = url
        self.timezone = timezone
        self.lang = lang
        self.phone = phone
        self.fareUrl = fareUrl
    }

    enum CodingKeys: String, CodingKey {
        case id = "agency_id"
        case name = "agency_name"
        case url = "agency_url"
        case timezone = "agency_timezone"
        case lang = "agency_lang"
        case phone = "agency_phone"
        case fareUrl = "agency_fare_url"
    }
}

extension Agency {
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

extension Agency: Equatable {
    public static func == (lhs: Agency, rhs: Agency) -> Bool {
        guard let leftId = lhs.id else {
            return false
        }
        guard let rightId = rhs.id else {
            return false
        }
        return leftId == rightId
    }
}

extension Agency {
    public func compare(with: Agency) -> Bool {
        return self.id == with.id
            && self.name == with.name
            && self.url == with.url
            && self.timezone == with.timezone
            && self.lang == with.lang
            && self.phone == with.phone
            && self.fareUrl == with.fareUrl
    }
}

extension Array where Element == Agency {
    public func agency(for route: Route) throws -> Agency {
        return try route.agency(self)
    }
}
