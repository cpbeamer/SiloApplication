//
//  CryptoCurrency.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class CryptoCurrency: Codable {

  enum CodingKeys: String, CodingKey {
    case totalSupply = "total_supply"
    case cmcRank = "cmc_rank"
    case dateAdded = "date_added"
    case tags
    case isFiat = "is_fiat"
    case maxSupply = "max_supply"
    case name
    case isActive = "is_active"
    case circulatingSupply = "circulating_supply"
    case slug
    case quote
    case lastUpdated = "last_updated"
    case assetId = "symbol"
    case id
    case numMarketPairs = "num_market_pairs"
  }

  var totalSupply: Double?
  var cmcRank: Int?
  var dateAdded: String?
  var tags: [String]?
  var isFiat: Int?
  var maxSupply: Int?
  var name: String?
  var isActive: Int?
  var circulatingSupply: Double?
  var slug: String?
  var quote: CurrencyQuote?
  var lastUpdated: String?
  var assetId: String?
  var id: Int?
  var numMarketPairs: Int?
  var isSelected = false
  var balance: String = "fetching..."
  var walletPercent: Double = 0


    required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    totalSupply = try container.decodeIfPresent(Double.self, forKey: .totalSupply)
    cmcRank = try container.decodeIfPresent(Int.self, forKey: .cmcRank)
    dateAdded = try container.decodeIfPresent(String.self, forKey: .dateAdded)
    tags = try container.decodeIfPresent([String].self, forKey: .tags)
    isFiat = try container.decodeIfPresent(Int.self, forKey: .isFiat)
    maxSupply = try container.decodeIfPresent(Int.self, forKey: .maxSupply)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    isActive = try container.decodeIfPresent(Int.self, forKey: .isActive)
    circulatingSupply = try container.decodeIfPresent(Double.self, forKey: .circulatingSupply)
    slug = try container.decodeIfPresent(String.self, forKey: .slug)
    quote = try container.decodeIfPresent(CurrencyQuote.self, forKey: .quote)
    lastUpdated = try container.decodeIfPresent(String.self, forKey: .lastUpdated)
    assetId = try container.decodeIfPresent(String.self, forKey: .assetId)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    numMarketPairs = try container.decodeIfPresent(Int.self, forKey: .numMarketPairs)
  }

}
