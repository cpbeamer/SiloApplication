//
//  NotificationList.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct NotificationList: Codable {

  enum CodingKeys: String, CodingKey {
    case notifications = "data"
    case statusCode
    case message
    case total
    case type
    case nextPage
    case limit
  }

  var notifications: [NotificationData]?
  var statusCode: Int?
  var message: String?
  var total: Int?
  var type: String?
  var nextPage: Int?
  var limit: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    notifications = try container.decodeIfPresent([NotificationData].self, forKey: .notifications)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    total = try container.decodeIfPresent(Int.self, forKey: .total)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    nextPage = try container.decodeIfPresent(Int.self, forKey: .nextPage)
    limit = try container.decodeIfPresent(Int.self, forKey: .limit)
  }

}
