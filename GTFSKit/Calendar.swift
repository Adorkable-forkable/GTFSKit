//
//  Calendar.swift
//  GTFSKit
//

import Foundation

public struct Calendar: Decodable {
    public let serviceId: String                    // service_id               (Required)
    public let monday: Bool                         // monday                   (Required)
    public let tuesday: Bool                        // tuesday                  (Required)
    public let wednesday: Bool                      // wednesday                (Required)
    public let thursday: Bool                       // thursday                 (Required)
    public let friday: Bool                         // friday                   (Required)
    public let saturday: Bool                       // saturday                 (Required)
    public let sunday: Bool                         // sunday                   (Required)
    public let startDate: Date                    // start_date               (Required)
    public let endDate: Date                      // end_date                 (Required)

    enum CodingKeys : String, CodingKey {
        case serviceId = "service_id"
        case monday = "monday"
        case tuesday = "tuesday"
        case wednesday = "wednesday"
        case thursday = "thursday"
        case friday = "friday"
        case saturday = "saturday"
        case sunday = "sunday"
        case startDate = "start_date"
        case endDate = "end_date"
    }
    
    static var timeDateFormatter: DateFormatter {
        let result = DateFormatter()
        result.dateFormat = "yyyyMMdd"
        return result
    }
    
    private static func decode(from container: KeyedDecodingContainer<Calendar.CodingKeys>, forKey key: CodingKeys) throws -> Date {
        let stringValue = try container.decode(String.self, forKey: key)
        
        guard let result = Calendar.timeDateFormatter.date(from: stringValue) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [key], debugDescription: "Invalid time format, expected '\(Calendar.timeDateFormatter.dateFormat)', received value '\(stringValue)'"))
        }
        return result
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.serviceId = try container.decode(String.self, forKey: .serviceId)

        self.monday = try container.decode(Bool.self, forKey: .monday)
        self.tuesday = try container.decode(Bool.self, forKey: .tuesday)
        self.wednesday = try container.decode(Bool.self, forKey: .wednesday)
        self.thursday = try container.decode(Bool.self, forKey: .thursday)
        self.friday = try container.decode(Bool.self, forKey: .friday)
        self.saturday = try container.decode(Bool.self, forKey: .saturday)
        self.sunday = try container.decode(Bool.self, forKey: .sunday)

        self.startDate = try Calendar.decode(from: container, forKey: .startDate)
        self.endDate = try Calendar.decode(from: container, forKey: .endDate)
    }
}

extension GTFSKit.Calendar {
    public func calendarDates(_ calendarDates: [CalendarDate]) -> [CalendarDate] {
        return calendarDates.filter({ (calendarDate) -> Bool in
            return calendarDate.serviceId == self.serviceId
        })
    }
}

extension Array where Element == GTFSKit.Calendar {
    public func calendar(for calendarDate: CalendarDate) throws -> GTFSKit.Calendar {
        return try calendarDate.calendar(self)
    }
}
