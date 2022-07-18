//
//  LocalCurrency.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class LocalCurrency: Codable {

  enum CodingKeys: String, CodingKey {
    case percentChange30d = "percent_change_30d"
    case percentChange90d = "percent_change_90d"
    case marketCap = "market_cap"
    case percentChange60d = "percent_change_60d"
    case volume24h = "volume_24h"
    case lastUpdated = "last_updated"
    case percentChange7d = "percent_change_7d"
    case percentChange1h = "percent_change_1h"
    case price
    case percentChange24h = "percent_change_24h"
  }

  var percentChange30d: Double?
  var percentChange90d: Double?
  var marketCap: Double?
  var percentChange60d: Double?
  var volume24h: Double?
  var lastUpdated: String?
  var percentChange7d: Double?
  var percentChange1h: Double?
  var price: Double?
  var percentChange24h: Double?



    required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    percentChange30d = try container.decodeIfPresent(Double.self, forKey: .percentChange30d)
    percentChange90d = try container.decodeIfPresent(Double.self, forKey: .percentChange90d)
    marketCap = try container.decodeIfPresent(Double.self, forKey: .marketCap)
    percentChange60d = try container.decodeIfPresent(Double.self, forKey: .percentChange60d)
    volume24h = try container.decodeIfPresent(Double.self, forKey: .volume24h)
    lastUpdated = try container.decodeIfPresent(String.self, forKey: .lastUpdated)
    percentChange7d = try container.decodeIfPresent(Double.self, forKey: .percentChange7d)
    percentChange1h = try container.decodeIfPresent(Double.self, forKey: .percentChange1h)
    price = try container.decodeIfPresent(Double.self, forKey: .price)
    percentChange24h = try container.decodeIfPresent(Double.self, forKey: .percentChange24h)
  }

}
