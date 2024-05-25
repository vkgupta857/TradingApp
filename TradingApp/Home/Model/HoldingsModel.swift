//
//  HoldingsModel.swift
//  TradingApp
//
//  Created by Vinod Gupta on 23/05/24.
//

import Foundation

// MARK: - Welcome
struct HoldingsModel: Codable {
    let data: HoldingsData?
}

// MARK: - DataClass
struct HoldingsData: Codable {
    let userHolding: [UserHolding]?
}

// MARK: - UserHolding
struct UserHolding: Codable {
    let symbol: String?
    let quantity: Int?
    let ltp, avgPrice, close: Double?
}
