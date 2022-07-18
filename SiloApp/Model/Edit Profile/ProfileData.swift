//
//  ProfileData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct ProfileData: Codable {

  enum CodingKeys: String, CodingKey {
    case phoneNo
    case userName
    case type
    case name
    case email
    case countryCode
    case profilePhoto
    case message
    case statusCode
  }

  var phoneNo: String?
  var userName: String?
  var type: String?
  var name: String?
  var email: String?
  var countryCode: String?
  var profilePhoto: String?
  var message: String?
  var statusCode: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    phoneNo = try container.decodeIfPresent(String.self, forKey: .phoneNo)
    userName = try container.decodeIfPresent(String.self, forKey: .userName)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    email = try container.decodeIfPresent(String.self, forKey: .email)
    countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
    profilePhoto = try container.decodeIfPresent(String.self, forKey: .profilePhoto)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
  }

}
