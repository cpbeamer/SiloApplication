//
//  CurrencyQuote.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class CurrencyQuote: Codable {

  enum CodingKeys: String, CodingKey {
    case usd = "USD"
    case aud = "AUD"
    case gbp = "GBP"
    case cad = "CAD"
    case cny = "CNY"
    case eur = "EUR"
  }

  var usd: LocalCurrency?
  var aud: LocalCurrency?
  var gbp: LocalCurrency?
  var cad: LocalCurrency?
  var cny: LocalCurrency?
  var eur: LocalCurrency?


    required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    usd = try container.decodeIfPresent(LocalCurrency.self, forKey: .usd)
    aud = try container.decodeIfPresent(LocalCurrency.self, forKey: .aud)
    gbp = try container.decodeIfPresent(LocalCurrency.self, forKey: .gbp)
    cad = try container.decodeIfPresent(LocalCurrency.self, forKey: .cad)
    cny = try container.decodeIfPresent(LocalCurrency.self, forKey: .cny)
    eur = try container.decodeIfPresent(LocalCurrency.self, forKey: .eur)
  }

    var localCurrency: LocalCurrency? {
        switch Defaults.localCurrency {
        case "USD":
            return usd
        case "AUD":
            return aud
        case "GBP":
            return gbp
        case "CAD":
            return cad
        case "CNY":
            return cny
        case "EUR":
            return eur
        default:
            return usd
        }
    }
    
}
