//
//  CalendarDate.swift
//  GTFSKit
//

import Foundation

public struct CalendarDate: CSVParsable {
    public let serviceId: String                    // service_id                (Required)
    public let date: Date                         // date                      (Required)
    public let exceptionType: ExceptionType         // exception_type            (Required)

    public init(serviceId: String, date: Date, exceptionType: ExceptionType) {
        self.serviceId = serviceId
        self.date = date
        self.exceptionType = exceptionType
    }

    public static func parse(data: CSVData) -> CalendarDate? {
        if !data.contains(columnNames: "service_id", "date", "exception_type") {
            return nil
        }

        let serviceId = data["service_id"]!

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"

        let date = formatter.date(from: data["date"]!)!

        let exceptionType = data.get(columnName: "exception_type", parser: ExceptionType.fromString)!

        return CalendarDate(serviceId: serviceId, date: date, exceptionType: exceptionType)
    }

}
