//
//  Status.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class Status: Codable {

  enum CodingKeys: String, CodingKey {
    case timestamp
    case errorCode = "error_code"
    case elapsed
    case creditCount = "credit_count"
  }

  var timestamp: String?
  var errorCode: Int?
  var elapsed: Int?
  var creditCount: Int?



    required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp)
    errorCode = try container.decodeIfPresent(Int.self, forKey: .errorCode)
    elapsed = try container.decodeIfPresent(Int.self, forKey: .elapsed)
    creditCount = try container.decodeIfPresent(Int.self, forKey: .creditCount)
  }

}
