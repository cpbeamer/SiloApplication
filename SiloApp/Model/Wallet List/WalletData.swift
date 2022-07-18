//
//  WalletData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct WalletData: Codable {

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case walletName = "wallet_name"
    case currencyName = "currency_name"
    case userId
    case createdAt
    case assetId = "asset_id"
    case walletAddress = "wallet_address"
  }

  var id: String?
  var walletName: String?
  var currencyName: String?
  var userId: String?
  var createdAt: String?
  var assetId: String?
  var walletAddress: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    walletName = try container.decodeIfPresent(String.self, forKey: .walletName)
    currencyName = try container.decodeIfPresent(String.self, forKey: .currencyName)
    userId = try container.decodeIfPresent(String.self, forKey: .userId)
    createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
    assetId = try container.decodeIfPresent(String.self, forKey: .assetId)
    walletAddress = try container.decodeIfPresent(String.self, forKey: .walletAddress)
  }

}
