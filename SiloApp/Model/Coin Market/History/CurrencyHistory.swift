//
//  CurrencyHistory.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class CurrencyHistory: Codable {

  enum CodingKeys: String, CodingKey {
    case symbol
    case id
    case quotes
    case name
  }

  var symbol: String?
  var id: Int?
  var quotes: [HistoryQuotes]?
  var name: String?

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    symbol = try container.decodeIfPresent(String.self, forKey: .symbol)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    quotes = try container.decodeIfPresent([HistoryQuotes].self, forKey: .quotes)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
