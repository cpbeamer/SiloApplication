//
//  Platform.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class Platform: Codable {

  enum CodingKeys: String, CodingKey {
    case tokenAddress = "token_address"
    case slug
    case symbol
    case name
    case id
  }

  var tokenAddress: String?
  var slug: String?
  var symbol: String?
  var name: String?
  var id: Int?



    required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    tokenAddress = try container.decodeIfPresent(String.self, forKey: .tokenAddress)
    slug = try container.decodeIfPresent(String.self, forKey: .slug)
    symbol = try container.decodeIfPresent(String.self, forKey: .symbol)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
