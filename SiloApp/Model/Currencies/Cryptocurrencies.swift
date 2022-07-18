//
//  Cryptocurrencies.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct Cryptocurrencies: Codable {

  enum CodingKeys: String, CodingKey {
    case walletAddress = "wallet_address"
    case id = "_id"
    case coinBalance = "coin_balance"
    case assetId = "asset_id"
    case currencyName = "currency_name"
    case enabled
  }

  var walletAddress: String?
  var id: String?
  var coinBalance: Int?
  var assetId: String?
  var currencyName: String?
  var enabled: Bool?
  var walletBalance: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    walletAddress = try container.decodeIfPresent(String.self, forKey: .walletAddress)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    coinBalance = try container.decodeIfPresent(Int.self, forKey: .coinBalance)
    assetId = try container.decodeIfPresent(String.self, forKey: .assetId)
    currencyName = try container.decodeIfPresent(String.self, forKey: .currencyName)
    enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
  }

}
