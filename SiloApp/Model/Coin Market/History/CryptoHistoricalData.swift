//
//  CryptoHistoricalData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class CryptoHistoricalData: Codable {

  enum CodingKeys: String, CodingKey {
    case status
    case history = "data"
  }

  var status: Status?
  var history: CurrencyHistory?

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    status = try container.decodeIfPresent(Status.self, forKey: .status)
    history = try container.decodeIfPresent(CurrencyHistory.self, forKey: .history)
  }

}
