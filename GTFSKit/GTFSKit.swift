//
//  GTFSKit.swift
//  GTFSKit
//

import Foundation

public enum LocationType: Int, Decodable {
    case stop = 0
    case station = 1
}

public enum Accessibility: Int, Decodable {
    case unknown = 0
    case some = 1
    case none = 2
}

public enum RouteType: Int, Decodable {
    case street = 0
    case underground = 1
    case rail = 2
    case bus = 3
    case ferry = 4
    case cable = 5
    case suspended = 6
    case inclineRail = 7
}

public enum TransferType: Int, Decodable {
    case recommended = 0
    case timed = 1
    case minimum = 2
    case none = 3
}

public enum ExceptionType: Int, Decodable {
    case added = 1
    case removed = 2
}

public enum Direction: Int, Decodable {
    case forward = 0
    case backward = 1
}

public enum BoardingType: Int, Decodable {
    case regular = 0
    case none = 1
    case mustPhone = 2
    case mustCoordinate = 3
}

public enum Timepoint: Int, Decodable {
    case approximate = 0
    case exact = 1
}
