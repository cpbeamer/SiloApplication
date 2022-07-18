//
//  Contacts.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct Contacts: Codable {
    
    enum CodingKeys: String, CodingKey {
      case deleted
      case appUser
      case contactName
      case isExternal
      case mobile
      case contactEmail
      case contactId
      case isFriend
      case userId
      case id = "_id"
      case createdAt
      case updatedAt
      case isAppUser
    }

    var deleted: Bool?
    var appUser: AppUser?
    var contactName: String?
    var isExternal: Bool?
    var mobile: Mobile?
    var contactEmail: String?
    var contactId: String?
    var isFriend: Bool?
    var userId: String?
    var id: String?
    var createdAt: String?
    var updatedAt: String?
    var isAppUser: Bool?



    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
      appUser = try container.decodeIfPresent(AppUser.self, forKey: .appUser)
      contactName = try container.decodeIfPresent(String.self, forKey: .contactName)
      isExternal = try container.decodeIfPresent(Bool.self, forKey: .isExternal)
      mobile = try container.decodeIfPresent(Mobile.self, forKey: .mobile)
      contactEmail = try container.decodeIfPresent(String.self, forKey: .contactEmail)
      contactId = try container.decodeIfPresent(String.self, forKey: .contactId)
      isFriend = try container.decodeIfPresent(Bool.self, forKey: .isFriend)
      userId = try container.decodeIfPresent(String.self, forKey: .userId)
      id = try container.decodeIfPresent(String.self, forKey: .id)
      createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
      updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
      isAppUser = try container.decodeIfPresent(Bool.self, forKey: .isAppUser)
    }

  }
