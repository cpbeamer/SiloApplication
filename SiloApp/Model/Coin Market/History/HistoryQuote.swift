//
//  HistoryQuote.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class HistoryQuote: Codable {

  enum CodingKeys: String, CodingKey {
    case usd = "USD"
    case aud = "AUD"
    case gbp = "GBP"
    case cad = "CAD"
    case cny = "CNY"
    case eur = "EUR"
  }

  var usd: LocalCurrenyConversion?
  var aud: LocalCurrenyConversion?
  var gbp: LocalCurrenyConversion?
  var cad: LocalCurrenyConversion?
  var cny: LocalCurrenyConversion?
  var eur: LocalCurrenyConversion?

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    usd = try container.decodeIfPresent(LocalCurrenyConversion.self, forKey: .usd)
    aud = try container.decodeIfPresent(LocalCurrenyConversion.self, forKey: .aud)
    gbp = try container.decodeIfPresent(LocalCurrenyConversion.self, forKey: .gbp)
    cad = try container.decodeIfPresent(LocalCurrenyConversion.self, forKey: .cad)
    cny = try container.decodeIfPresent(LocalCurrenyConversion.self, forKey: .cny)
    eur = try container.decodeIfPresent(LocalCurrenyConversion.self, forKey: .eur)
  }

    var localCurrency: LocalCurrenyConversion? {
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
