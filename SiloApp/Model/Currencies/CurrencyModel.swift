//
//  CurrencyModel.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

class CurrencyModel: Codable {
    
    var assetId: String
    var name: String
    var price: Double?
    var oldPrice: Double?
    var isSelected = false
    
    enum CodingKeys: String, CodingKey {
        case assetId = "asset_id"
        case name
        case price = "price_usd"
    }
    
    init(assetId: String, name: String) {
        self.assetId = assetId
        self.name = name
        self.price = 0.0
        self.oldPrice = self.price
    }
}

struct SupporedCurrencyModel {
    var name: String
    var assetId: String
}

enum CryptoAssetId: String {
    case BTC = "BTC"
    case ETH = "ETH"
    case USDT = "USDT"
    case XRP = "XRP"
    case LTC = "LTC"
    case BCH = "BCH"
    case ADA = "ADA"
    case EOS = "EOS"
    case XMR = "XMR"
    case XLM = "XLM"
    case TRX = "TRX"
    case DOT = "DOT"
}
