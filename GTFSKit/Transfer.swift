//
//  Transfer.swift
//  GTFSKit
//

import Foundation

public struct Transfer: Decodable {
    public let fromStopId: String                   // from_stop_id              (Required)
    public let toStopId: String                     // to_stop_id                (Required)
    public let transferType: TransferType           // transfer_type             (Required)
    public let minTransferTime: Int?                // min_transfer_time         (Optional)
    
    enum CodingKeys : String, CodingKey {
        case fromStopId = "from_stop_id"
        case toStopId = "to_stop_id"
        
        case transferType = "transfer_type"
        
        case minTransferTime = "min_transfer_time"
    }
}

extension Transfer {
    public func fromStop(stops: [Stop]) throws -> Stop {
        return try stops.filterOne({ (stop) -> Bool in
            return stop.id == self.fromStopId
        })
    }
    
    public func toStop(stops: [Stop]) throws -> Stop {
        return try stops.filterOne({ (stop) -> Bool in
            return stop.id == self.toStopId
        })
    }
}
