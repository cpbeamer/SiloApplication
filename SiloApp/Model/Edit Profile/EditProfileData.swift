//
//  EditProfileData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct EditProfileData: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case type
    case statusCode
    case editRequest = "edit_request"
  }

  var message: String?
  var type: String?
  var statusCode: Int?
  var editRequest: EditRequest?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    editRequest = try container.decodeIfPresent(EditRequest.self, forKey: .editRequest)
  }

}
