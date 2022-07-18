//
//  CryptoCurrenciesData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class CryptoCurrenciesData: Codable {

  enum CodingKeys: String, CodingKey {
    case data
    case status
  }

  var data: Currencies?
  var status: Status?



    required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    data = try container.decodeIfPresent(Currencies.self, forKey: .data)
    status = try container.decodeIfPresent(Status.self, forKey: .status)
  }

}
