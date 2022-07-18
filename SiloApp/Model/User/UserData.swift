//
//  UserData.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct UserData: Codable {

    enum KYCStatus : String, Codable {
        case pending = "OPEN"
        case inProcess = "PENDING"
        case completed = "APPROVED"
    }
    
  enum CodingKeys: String, CodingKey {
    case authToken
    case allCryptocurrencies = "cryptocurrencies"
    case id = "_id"
    case statusCode
    case message
    case phoneNo
    case type
    case name
    case userName
    case email
    case countryCode
    case completeProfileStep
    case pinSize = "pin_size"
    case profilePhoto
    case isPhoneVerified
    case isEmailVerified
    case fullPhoneNo
    case updatedAt
    case hash
    case status
    case recoveryPhase
    case createdAt
    case userSalt
    case saltIndex
    case wyreAccountId
    case kycStatus
  }

  var authToken: String?
  var allCryptocurrencies: [Cryptocurrencies]?
  var cryptocurrencies: [Cryptocurrencies]?
  var id: String?
  var statusCode: Int?
  var message: String?
  var phoneNo: String?
  var type: String?
  var name: String?
  var userName: String?
  var email: String?
  var countryCode: String?
  var completeProfileStep: Int?
  var pinSize: Int?
  var profilePhoto: String?
  var isPhoneVerified: Bool?
  var isEmailVerified: Bool?
  var fullPhoneNo: String?
  var updatedAt: String?
  var hash: String?
  var status: Int?
  var recoveryPhase: String?
  var createdAt: String?
  var userSalt: String?
  var saltIndex: Int?
  var wyreAccountId: String?
  var kycStatus: KYCStatus?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    authToken = try container.decodeIfPresent(String.self, forKey: .authToken)
    allCryptocurrencies = try container.decodeIfPresent([Cryptocurrencies].self, forKey: .allCryptocurrencies)
    cryptocurrencies = self.allCryptocurrencies?.filter({($0.enabled ?? false)})
    id = try container.decodeIfPresent(String.self, forKey: .id)
    statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    phoneNo = try container.decodeIfPresent(String.self, forKey: .phoneNo)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    userName = try container.decodeIfPresent(String.self, forKey: .userName)
    email = try container.decodeIfPresent(String.self, forKey: .email)
    countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
    completeProfileStep = try container.decodeIfPresent(Int.self, forKey: .completeProfileStep)
    pinSize = try container.decodeIfPresent(Int.self, forKey: .pinSize)
    profilePhoto = try container.decodeIfPresent(String.self, forKey: .profilePhoto)
    isPhoneVerified = try container.decodeIfPresent(Bool.self, forKey: .isPhoneVerified)
    isEmailVerified = try container.decodeIfPresent(Bool.self, forKey: .isEmailVerified)
    fullPhoneNo = try container.decodeIfPresent(String.self, forKey: .fullPhoneNo)
    updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
    hash = try container.decodeIfPresent(String.self, forKey: .hash)
    status = try container.decodeIfPresent(Int.self, forKey: .status)
    recoveryPhase = try container.decodeIfPresent(String.self, forKey: .recoveryPhase)
    createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
    userSalt = try container.decodeIfPresent(String.self, forKey: .userSalt)
    saltIndex = try container.decodeIfPresent(Int.self, forKey: .saltIndex)
    wyreAccountId = try container.decodeIfPresent(String.self, forKey: .wyreAccountId)
    kycStatus = try container.decodeIfPresent(KYCStatus.self, forKey: .kycStatus)
  }
    
}
