//
//  Calendar.swift
//  GTFSKit
//

import Foundation

public struct Calendar: CSVParsable {
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

    public static func parse(data: CSVData) -> Calendar? {
        if !data.contains(columnNames: "service_id", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday", "start_date", "end_date") {
            return nil
        }

        let serviceId = data["service_id"]!
        let monday = data.get(columnName: "monday", parser: { $0 == "1" })!
        let tuesday = data.get(columnName: "tuesday", parser: { $0 == "1" })!
        let wednesday = data.get(columnName: "wednesday", parser: { $0 == "1" })!
        let thursday = data.get(columnName: "thursday", parser: { $0 == "1" })!
        let friday = data.get(columnName: "friday", parser: { $0 == "1" })!
        let saturday = data.get(columnName: "saturday", parser: { $0 == "1" })!
        let sunday = data.get(columnName: "sunday", parser: { $0 == "1" })!

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"

        let startDate = formatter.date(from: data["start_date"]!)!
        let endDate = formatter.date(from: data["start_date"]!)!

        return Calendar(serviceId: serviceId, monday: monday, tuesday: tuesday, wednesday: wednesday, thursday: thursday, friday: friday, saturday: saturday, sunday: sunday, startDate: startDate, endDate: endDate)
    }

}
