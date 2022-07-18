//
//  Currencies.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class Currencies: Codable {

  enum CodingKeys: String, CodingKey {
    case ada = "ADA"
    case bch = "BCH"
    case xrp = "XRP"
    case dot = "DOT"
    case btc = "BTC"
    case eth = "ETH"
    case usdt = "USDT"
    case eos = "EOS"
    case xlm = "XLM"
    case xmr = "XMR"
    case trx = "TRX"
    case ltc = "LTC"
  }

  var ada: CryptoCurrency?
  var bch: CryptoCurrency?
  var xrp: CryptoCurrency?
  var dot: CryptoCurrency?
  var btc: CryptoCurrency?
  var eth: CryptoCurrency?
  var usdt: CryptoCurrency?
  var eos: CryptoCurrency?
  var xlm: CryptoCurrency?
  var xmr: CryptoCurrency?
  var trx: CryptoCurrency?
  var ltc: CryptoCurrency?



    required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    ada = try container.decodeIfPresent(CryptoCurrency.self, forKey: .ada)
    bch = try container.decodeIfPresent(CryptoCurrency.self, forKey: .bch)
    xrp = try container.decodeIfPresent(CryptoCurrency.self, forKey: .xrp)
    dot = try container.decodeIfPresent(CryptoCurrency.self, forKey: .dot)
    btc = try container.decodeIfPresent(CryptoCurrency.self, forKey: .btc)
    eth = try container.decodeIfPresent(CryptoCurrency.self, forKey: .eth)
    usdt = try container.decodeIfPresent(CryptoCurrency.self, forKey: .usdt)
    eos = try container.decodeIfPresent(CryptoCurrency.self, forKey: .eos)
    xlm = try container.decodeIfPresent(CryptoCurrency.self, forKey: .xlm)
    xmr = try container.decodeIfPresent(CryptoCurrency.self, forKey: .xmr)
    trx = try container.decodeIfPresent(CryptoCurrency.self, forKey: .trx)
    ltc = try container.decodeIfPresent(CryptoCurrency.self, forKey: .ltc)
  }

    var currencies: [CryptoCurrency] {
        var data: [CryptoCurrency] = []
        if let btc = btc {
            data.append(btc)
        }
        if let eth = eth {
            data.append(eth)
        }
        if let usdt = usdt {
            data.append(usdt)
        }
        if let xrp = xrp {
            data.append(xrp)
        }
        if let ltc = ltc {
            data.append(ltc)
        }
        if let bch = bch {
            data.append(bch)
        }
        if let ada = ada {
            data.append(ada)
        }
        if let eos = eos {
            data.append(eos)
        }
        if let xmr = xmr {
            data.append(xmr)
        }
        if let xlm = xlm {
            data.append(xlm)
        }
        if let trx = trx {
            data.append(trx)
        }
        if let dot = dot {
            data.append(dot)
        }
        return data
    }
    
}
