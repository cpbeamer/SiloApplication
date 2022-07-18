//
//  Requests.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct Requests: Codable {

  enum CodingKeys: String, CodingKey {
    case coinAmount
    case message
    case receiverId
    case createdAt
    case status
    case fiatCurrency
    case totalCoinAmount
    case userId
    case id = "_id"
    case updatedAt
    case assetId = "asset_id"
    case fiatAmount
    case profilePhoto
    case userName
    case name
  }

  var coinAmount: String?
  var message: String?
  var receiverId: String?
  var createdAt: String?
  var status: String?
  var fiatCurrency: String?
  var totalCoinAmount: String?
  var userId: String?
  var id: String?
  var updatedAt: String?
  var assetId: String?
  var fiatAmount: String?
  var profilePhoto: String?
  var userName: String?
  var name: String?
  var showingFullMessage = false


  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    coinAmount = try container.decodeIfPresent(String.self, forKey: .coinAmount)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    receiverId = try container.decodeIfPresent(String.self, forKey: .receiverId)
    createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    fiatCurrency = try container.decodeIfPresent(String.self, forKey: .fiatCurrency)
    totalCoinAmount = try container.decodeIfPresent(String.self, forKey: .totalCoinAmount)
    userId = try container.decodeIfPresent(String.self, forKey: .userId)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
    assetId = try container.decodeIfPresent(String.self, forKey: .assetId)
    fiatAmount = try container.decodeIfPresent(String.self, forKey: .fiatAmount)
    profilePhoto = try container.decodeIfPresent(String.self, forKey: .profilePhoto)
    userName = try container.decodeIfPresent(String.self, forKey: .userName)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

    var statusValue: String? {
        switch self.status {
        case "0":
            return AppStrings.pending.localized
        case "1":
            return AppStrings.completed.localized
        case "2":
            return AppStrings.declined.localized
        default:
            return nil
        }
    }
    
    var statusColor: UIColor? {
        switch self.status {
        case "0":
            return AppColors.pending
        case "1":
            return AppColors.authorise
        case "2":
            return AppColors.warning
        default:
            return nil
        }
    }
    
    mutating func updateShowingFullMessage() {
        self.showingFullMessage.toggle()
    }
}
