//
//  CalendarDate.swift
//  GTFSKit
//

import Foundation

public struct CalendarDate: Codable {
    public let serviceId: String                    // service_id                (Required)
    public let date: Date                           // date                      (Required)
    public let exceptionType: ExceptionType         // exception_type            (Required)

    public init(serviceId: String, date: Date, exceptionType: ExceptionType) {
        self.serviceId = serviceId
        self.date = date
        self.exceptionType = exceptionType
    }
    
    enum CodingKeys : String, CodingKey {
        case serviceId = "service_id"
        case date = "date"
        case exceptionType = "exception_type"
    }
    
    static var timeDateFormatter: DateFormatter {
        let result = DateFormatter()
        result.dateFormat = "yyyyMMdd"
        result.timeZone = TimeZone(abbreviation: "UTC")
        return result
    }
    
    private static func decode(from container: KeyedDecodingContainer<CalendarDate.CodingKeys>, forKey key: CodingKeys) throws -> Date {
        let stringValue = try container.decode(String.self, forKey: key)
        
        guard let result = CalendarDate.timeDateFormatter.date(from: stringValue) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [key], debugDescription: "Invalid time format, expected '\(Calendar.timeDateFormatter.dateFormat)', received value '\(stringValue)'"))
        }
        return result
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.serviceId = try container.decode(String.self, forKey: .serviceId)
        
        self.date = try container.decode(Date.self, forKey: .date, formatter: CalendarDate.timeDateFormatter)

        self.exceptionType = try container.decode(ExceptionType.self, forKey: .exceptionType)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.serviceId, forKey: .serviceId)
        
        try container.encode(self.date, forKey: .date, formatter: CalendarDate.timeDateFormatter)
        
        try container.encode(self.exceptionType, forKey: .exceptionType)
    }
}

extension CalendarDate {
    public func calendar(_ calendars: [GTFSKit.Calendar]) throws -> GTFSKit.Calendar {
        return try calendars.filterOne({ (calendar) -> Bool in
            return calendar.serviceId == self.serviceId
        })
    }
}

extension CalendarDate: Equatable {
    public static func == (lhs: CalendarDate, rhs: CalendarDate) -> Bool {
        return lhs.serviceId == rhs.serviceId
            
            && lhs.date == rhs.date
            
            && lhs.exceptionType == rhs.exceptionType
    }
}

extension Array where Element == CalendarDate {
    public func calendarDates(for calendar: GTFSKit.Calendar) -> [CalendarDate] {
        return calendar.calendarDates(self)
    }
}
