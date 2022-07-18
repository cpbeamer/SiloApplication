//
//  UserNameExistData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct UserNameExistData: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case type
    case statusCode
  }

  var message: String?
  var type: String?
  var statusCode: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
  }

}
