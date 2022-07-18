//
//  RequestData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct RequestsData: Codable {

  enum CodingKeys: String, CodingKey {
    case nextPage
    case total
    case type
    case message
    case statusCode
    case data
    case limit
  }

  var nextPage: Int?
  var total: Int?
  var type: String?
  var message: String?
  var statusCode: Int?
  var data: [Requests]?
  var limit: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    nextPage = try container.decodeIfPresent(Int.self, forKey: .nextPage)
    total = try container.decodeIfPresent(Int.self, forKey: .total)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    data = try container.decodeIfPresent([Requests].self, forKey: .data)
    limit = try container.decodeIfPresent(Int.self, forKey: .limit)
  }

}
