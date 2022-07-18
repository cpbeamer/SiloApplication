//
//  AppUser.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct AppUser: Codable {

  enum CodingKeys: String, CodingKey {
    case profilePhoto
    case userId
    case userName
    case name
    case status
  }

  var profilePhoto: String?
  var userId: String?
  var userName: String?
  var name: String?
  var status: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    profilePhoto = try container.decodeIfPresent(String.self, forKey: .profilePhoto)
    userId = try container.decodeIfPresent(String.self, forKey: .userId)
    userName = try container.decodeIfPresent(String.self, forKey: .userName)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    status = try container.decodeIfPresent(Int.self, forKey: .status)
  }

    init(profilePhoto: String?, userId: String?, userName: String?, name: String?) {
        self.profilePhoto = profilePhoto
        self.userId = userId
        self.userName = userName
        self.name = name
    }
    
}
