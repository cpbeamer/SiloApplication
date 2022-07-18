//
//  Mobile.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//


import Foundation

struct Mobile: Codable {

  enum CodingKeys: String, CodingKey {
    case phoneNo
    case countryCode
    case fullPhoneNo
  }

  var phoneNo: String?
  var countryCode: String?
  var fullPhoneNo: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    phoneNo = try container.decodeIfPresent(String.self, forKey: .phoneNo)
    countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
    fullPhoneNo = try container.decodeIfPresent(String.self, forKey: .fullPhoneNo)
  }

}
