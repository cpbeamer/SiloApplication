//
//  LocalCurrencyConversion.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class LocalCurrenyConversion: Codable {

  enum CodingKeys: String, CodingKey {
    case price
    case timestamp
    case marketCap = "market_cap"
    case volume = "volume_24h"
  }

  var price: Double?
  var timestamp: String?
  var marketCap: Double?
  var volume: Double?

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    price = try container.decodeIfPresent(Double.self, forKey: .price)
    timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp)
    marketCap = try container.decodeIfPresent(Double.self, forKey: .marketCap)
    volume = try container.decodeIfPresent(Double.self, forKey: .volume)
  }

}
