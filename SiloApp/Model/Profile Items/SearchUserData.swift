//
//  SearchUserData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct SearchUserData: Codable {

  enum CodingKeys: String, CodingKey {
    case type
    case users = "data"
    case limit
    case statusCode
    case total
    case nextPage
    case message
  }

  var type: String?
  var users: [UserData]?
  var limit: Int?
  var statusCode: Int?
  var total: Int?
  var nextPage: Int?
  var message: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    users = try container.decodeIfPresent([UserData].self, forKey: .users)
    limit = try container.decodeIfPresent(Int.self, forKey: .limit)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    total = try container.decodeIfPresent(Int.self, forKey: .total)
    nextPage = try container.decodeIfPresent(Int.self, forKey: .nextPage)
    message = try container.decodeIfPresent(String.self, forKey: .message)
  }

}
