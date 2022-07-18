//
//  HistoryQuotes.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//


import Foundation

class HistoryQuotes: Codable {

  enum CodingKeys: String, CodingKey {
    case timeClose = "time_close"
    case timeHigh = "time_high"
    case timeLow = "time_low"
    case quote
    case timeOpen = "time_open"
  }

  var timeClose: String?
  var timeHigh: String?
  var timeLow: String?
  var quote: HistoryQuote?
  var timeOpen: String?

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    timeClose = try container.decodeIfPresent(String.self, forKey: .timeClose)
    timeHigh = try container.decodeIfPresent(String.self, forKey: .timeHigh)
    timeLow = try container.decodeIfPresent(String.self, forKey: .timeLow)
    quote = try container.decodeIfPresent(HistoryQuote.self, forKey: .quote)
    timeOpen = try container.decodeIfPresent(String.self, forKey: .timeOpen)
  }

}
