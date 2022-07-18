//
//  KeyContacts.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class KeyContacts: Codable {

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case contacts
  }

  var id: String?
  var contacts: [Contacts]?



  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    contacts = try container.decodeIfPresent([Contacts].self, forKey: .contacts)
  }

    init(id: String) {
        self.id = id
        self.contacts = []
    }
    
}
