//
//  WalletList.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct WalletList: Codable {

  enum CodingKeys: String, CodingKey {
    case type
    case message
    case total
    case statusCode
    case wallets = "data"
    case limit
    case nextPage
  }

  var type: String?
  var message: String?
  var total: Int?
  var statusCode: Int?
  var wallets: [WalletData]?
  var limit: Int?
  var nextPage: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    total = try container.decodeIfPresent(Int.self, forKey: .total)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    wallets = try container.decodeIfPresent([WalletData].self, forKey: .wallets)
    limit = try container.decodeIfPresent(Int.self, forKey: .limit)
    nextPage = try container.decodeIfPresent(Int.self, forKey: .nextPage)
  }

}
