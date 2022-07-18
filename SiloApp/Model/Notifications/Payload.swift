//
//  Payload.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct Payload: Codable {

    /*
     "1"= Name has requested for 1.5 ETH. ( Accept/Reject button )
     "2.= Name has joined SILO
     "3.= You have received 1.5 BTC from Name
     "4"= You have sucessfully sent 1.5 BTC to Name
     "5"= You have sucessfully exchanged 1.5 ETH to 7655 DAI.
     "6"= 1.5 ETH have been sucessfully added to your wallet.
     "7"= 1.5 ETH have been sucessfully transfer to your bank account ending 1234.
     "8"= Admin push notification.
     */
    enum NotificationType: String {
        case request = "1"
        case joined = "2"
        case receive = "3"
        case sent = "4"
        case exchange = "5"
        case addedToWallet = "6"
        case transfered = "7"
        case admin = "8"
    }
    
  enum CodingKeys: String, CodingKey {
    case type
    case title
    case body
    case image
    case meta = "metadata"
    case message
    case status
  }

  var type: String?
  var title: String?
  var body: String?
  var image: String?
  var meta: String?
  var message: String?
  var status: String?
  var notificationType: NotificationType?
  var metadata: JSONDictionary?


  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    body = try container.decodeIfPresent(String.self, forKey: .body)
    image = try container.decodeIfPresent(String.self, forKey: .image)
    meta = try container.decodeIfPresent(String.self, forKey: .meta)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    if let type = type {
        notificationType = NotificationType(rawValue: type)
    }
    metadata = CommonFunctions.stringToJson(meta)
  }

}
