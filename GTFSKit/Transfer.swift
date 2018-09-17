//
//  Transfer.swift
//  GTFSKit
//

import Foundation

public struct Transfer: Codable {
    public let fromStopId: String                   // from_stop_id              (Required)
    public let toStopId: String                     // to_stop_id                (Required)
    public let transferType: TransferType           // transfer_type             (Required)
    public let minTransferTime: Int?                // min_transfer_time         (Optional)
    
    public init(fromStopId: String, toStopId: String, transferType: TransferType, minTransferTime: Int?) {
        self.fromStopId = fromStopId
        self.toStopId = toStopId
        self.transferType = transferType
        self.minTransferTime = minTransferTime
    }
    
    enum CodingKeys : String, CodingKey {
        case fromStopId = "from_stop_id"
        case toStopId = "to_stop_id"
        
        case transferType = "transfer_type"
        
        case minTransferTime = "min_transfer_time"
    }
}

extension Transfer {
    public func fromStop(_ stops: [Stop]) throws -> Stop {
        return try stops.filterOne({ (stop) -> Bool in
            return stop.id == self.fromStopId
        })
    }
    
    public func toStop(_ stops: [Stop]) throws -> Stop {
        return try stops.filterOne({ (stop) -> Bool in
            return stop.id == self.toStopId
        })
    }
}

extension Transfer: Equatable {
    public static func == (lhs: Transfer, rhs: Transfer) -> Bool {
        return lhs.fromStopId == rhs.fromStopId
            && lhs.toStopId == rhs.toStopId
            && lhs.transferType == rhs.transferType
            && lhs.minTransferTime == rhs.minTransferTime
    }
}
