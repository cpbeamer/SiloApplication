//
//  UpdateRecoveryPhrase.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct UpdateRecoveryPhase: Codable {

  enum CodingKeys: String, CodingKey {
    case type
    case statusCode
    case message
    case wyreAccountId
  }

  var type: String?
  var statusCode: Int?
  var message: String?
  var wyreAccountId: String?


  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    wyreAccountId = try container.decodeIfPresent(String.self, forKey: .wyreAccountId)
  }

}
