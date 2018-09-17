//
//  Calendar.swift
//  GTFSKit
//

import Foundation

public struct Calendar: Codable {
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

    public init(serviceId: String, monday: Bool, tuesday: Bool, wednesday: Bool, thursday: Bool, friday: Bool, saturday: Bool, sunday: Bool, startDate: Date, endDate: Date) {
        self.serviceId = serviceId

        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
        
        self.startDate = startDate
        self.endDate = endDate
    }
    
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
        result.timeZone = TimeZone(abbreviation: "UTC")
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

        self.startDate = try container.decode(Date.self, forKey: .startDate, formatter: Calendar.timeDateFormatter)
        self.endDate = try container.decode(Date.self, forKey: .endDate, formatter: Calendar.timeDateFormatter)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.serviceId, forKey: .serviceId)
        
        try container.encode(self.monday, forKey: .monday)
        try container.encode(self.tuesday, forKey: .tuesday)
        try container.encode(self.wednesday, forKey: .wednesday)
        try container.encode(self.thursday, forKey: .thursday)
        try container.encode(self.friday, forKey: .friday)
        try container.encode(self.saturday, forKey: .saturday)
        try container.encode(self.sunday, forKey: .sunday)
        
        try container.encode(self.startDate, forKey: .startDate, formatter: Calendar.timeDateFormatter)
        try container.encode(self.endDate, forKey: .endDate, formatter: Calendar.timeDateFormatter)
    }
}

extension GTFSKit.Calendar {
    public func calendarDates(_ calendarDates: [CalendarDate]) -> [CalendarDate] {
        return calendarDates.filter({ (calendarDate) -> Bool in
            return calendarDate.serviceId == self.serviceId
        })
    }
}

extension GTFSKit.Calendar: Equatable {
    public static func == (lhs: GTFSKit.Calendar, rhs: GTFSKit.Calendar) -> Bool {
        return lhs.serviceId == rhs.serviceId
            
            && lhs.monday == rhs.monday
            && lhs.tuesday == rhs.tuesday
            && lhs.wednesday == rhs.wednesday
            && lhs.thursday == rhs.thursday
            && lhs.friday == rhs.friday
            && lhs.saturday == rhs.saturday
            && lhs.sunday == rhs.sunday
            
            && lhs.startDate == rhs.startDate
            && lhs.endDate == rhs.endDate
    }
}

extension Array where Element == GTFSKit.Calendar {
    public func calendar(for calendarDate: CalendarDate) throws -> GTFSKit.Calendar {
        return try calendarDate.calendar(self)
    }
}
