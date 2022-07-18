//
//  NotificationData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct NotificationData: Codable {

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case createdAt
    case userId
    case deleted
    case deviceToken
    case payload
    case type
  }

  var id: String?
  var createdAt: String?
  var userId: String?
  var deleted: Bool?
  var deviceToken: String?
  var payload: Payload?
  var type: String?
  var showingFullMessage = false


  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
    userId = try container.decodeIfPresent(String.self, forKey: .userId)
    deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
    deviceToken = try container.decodeIfPresent(String.self, forKey: .deviceToken)
    payload = try container.decodeIfPresent(Payload.self, forKey: .payload)
    type = try container.decodeIfPresent(String.self, forKey: .type)
  }

    mutating func updateShowingFullMessage() {
        self.showingFullMessage.toggle()
    }
}
