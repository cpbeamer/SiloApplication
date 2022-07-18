//
//  RecoveryPhaseData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct RecoveryPhraseData: Codable {

  enum CodingKeys: String, CodingKey {
    case userId
    case statusCode
    case recoveryPhase = "recovery_phase"
    case type
    case message
  }

  var userId: String?
  var statusCode: Int?
  var recoveryPhase: String?
  var type: String?
  var message: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    userId = try container.decodeIfPresent(String.self, forKey: .userId)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    recoveryPhase = try container.decodeIfPresent(String.self, forKey: .recoveryPhase)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    message = try container.decodeIfPresent(String.self, forKey: .message)
  }

}
