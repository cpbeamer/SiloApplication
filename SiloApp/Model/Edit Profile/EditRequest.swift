//
//  EditRequest.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct EditRequest: Codable {

  enum CodingKeys: String, CodingKey {
    case email
    case profilePhoto
    case name
  }

  var email: String?
  var profilePhoto: String?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    email = try container.decodeIfPresent(String.self, forKey: .email)
    profilePhoto = try container.decodeIfPresent(String.self, forKey: .profilePhoto)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
