//
//  UserProfileDetails.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct UserProfileDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case type
    case userDetails
    case isFriend
    case statusCode
    case message
  }

  var type: String?
  var userDetails: UserData?
  var isFriend: Bool?
  var statusCode: Int?
  var message: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    userDetails = try container.decodeIfPresent(UserData.self, forKey: .userDetails)
    isFriend = try container.decodeIfPresent(Bool.self, forKey: .isFriend)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    message = try container.decodeIfPresent(String.self, forKey: .message)
  }

}
