//
//  ForgotPasswordData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct ForgotPasswordData: Codable {

  enum CodingKeys: String, CodingKey {
    case statusCode
    case message
    case countryCode
    case otp
    case phoneNo
    case type
    case userId
    case otpTimeStamp
  }

  var statusCode: Int?
  var message: String?
  var countryCode: String?
  var otp: String?
  var phoneNo: String?
  var type: String?
  var userId: String?
  var otpTimeStamp: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
    otp = try container.decodeIfPresent(String.self, forKey: .otp)
    phoneNo = try container.decodeIfPresent(String.self, forKey: .phoneNo)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    userId = try container.decodeIfPresent(String.self, forKey: .userId)
    otpTimeStamp = try container.decodeIfPresent(Int.self, forKey: .otpTimeStamp)
  }

    init() { }
    
}
