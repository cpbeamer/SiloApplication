//
//  SettingsData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct SettingsData: Codable {

  enum CodingKeys: String, CodingKey {
    case type
    case statusCode
    case message
    case notificationEnabled
  }

  var type: String?
  var statusCode: Int?
  var message: String?
  var notificationEnabled: Bool?


  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    notificationEnabled = try container.decodeIfPresent(Bool.self, forKey: .notificationEnabled)
  }

}
