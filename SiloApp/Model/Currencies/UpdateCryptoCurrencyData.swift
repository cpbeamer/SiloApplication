//
//  UpdateCryptoCurrencyData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct UpdateCryptoCurrencyData: Codable {

  enum CodingKeys: String, CodingKey {
    case statusCode
    case message
    case data
    case type
  }

  var statusCode: Int?
  var message: String?
  var data: [Cryptocurrencies]?
  var type: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    data = try container.decodeIfPresent([Cryptocurrencies].self, forKey: .data)
    type = try container.decodeIfPresent(String.self, forKey: .type)
  }

}
