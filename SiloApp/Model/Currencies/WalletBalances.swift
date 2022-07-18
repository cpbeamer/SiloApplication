//
//  WalletBalances.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct WalletBalances: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case statusCode
        case message
        case ada = "ADA"
        case bch = "BCH"
        case xrp = "XRP"
        case dot = "DOT"
        case btc = "BTC"
        case eth = "ETH"
        case eos = "EOS"
        case xlm = "XLM"
        case xmr = "XMR"
        case trx = "TRX"
        case ltc = "LTC"
        case usdt = "USDT"
    }
    
    var type: String?
    var statusCode: Int?
    var message: String?
    var ada: String?
    var bch: String?
    var xrp: String?
    var dot: String?
    var btc: String?
    var eth: String?
    var eos: String?
    var xlm: String?
    var xmr: String?
    var trx: String?
    var ltc: String?
    var usdt: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        ada = try container.decodeIfPresent(String.self, forKey: .ada)
        bch = try container.decodeIfPresent(String.self, forKey: .bch)
        xrp = try container.decodeIfPresent(String.self, forKey: .xrp)
        dot = try container.decodeIfPresent(String.self, forKey: .dot)
        btc = try container.decodeIfPresent(String.self, forKey: .btc)
        eth = try container.decodeIfPresent(String.self, forKey: .eth)
        eos = try container.decodeIfPresent(String.self, forKey: .eos)
        xlm = try container.decodeIfPresent(String.self, forKey: .xlm)
        xmr = try container.decodeIfPresent(String.self, forKey: .xmr)
        trx = try container.decodeIfPresent(String.self, forKey: .trx)
        ltc = try container.decodeIfPresent(String.self, forKey: .ltc)
        usdt = try container.decodeIfPresent(String.self, forKey: .usdt)
    }
    
    
    func balance(assetId: String) -> String {
        switch assetId {
        case "ADA":
            return ada ?? "0"
        case "BCH":
            return bch ?? "0"
        case "XRP":
            return xrp ?? "0"
        case "DOT":
            return dot ?? "0"
        case "BTC":
            return btc ?? "0"
        case "ETH":
            return eth ?? "0"
        case "EOS":
            return eos ?? "0"
        case "XLM":
            return xlm ?? "0"
        case "XMR":
            return xmr ?? "0"
        case "TRX":
            return trx ?? "0"
        case "LTC":
            return ltc ?? "0"
        case "USDT":
            return usdt ?? "0"
        default:
            return "0"
        }
    }
}
