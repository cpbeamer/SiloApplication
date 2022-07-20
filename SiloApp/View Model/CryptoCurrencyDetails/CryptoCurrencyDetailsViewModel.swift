//
//  CryptoCurrencyDetailsViewModel.swift
//  SiloApp
//
//  Created by Cary Beam on 7/20/22.
//

import UIKit

class CryptoCurrencyDetailsViewModel: NSObject {
    
    private (set) var coin: CoinMarketCap
    var currency: CryptoCurrency?
    
    init(currency: CryptoCurrency?) {
        self.coin = CoinMarketCap(apiKey: AppConstants.coinMarketCapAPIKey)
        self.currency = currency
    }
    
    var updateGraph: (([HistoryQuotes]) -> ())?
    
    func getGraphData(unit: FilterUnit, limit: Int = 12) {
        
        let date = Date()
        var startTime = date.minus(days: UInt(1)).toString(dateFormat: AppConstants.coinAPITimeFormat)
        switch unit {
        case .hour:
            startTime = date.minus(hours: UInt(1)).toString(dateFormat: AppConstants.coinAPITimeFormat)
        case .day:
            startTime = date.minus(days: UInt(1)).toString(dateFormat: AppConstants.coinAPITimeFormat)
        case .week:
            startTime = date.minus(weeks: UInt(1)).toString(dateFormat: AppConstants.coinAPITimeFormat)
        case .month:
            startTime = date.minus(months: UInt(1)).toString(dateFormat: AppConstants.coinAPITimeFormat)
        case .quarter:
            startTime = date.minus(months: UInt(3)).plus(days: UInt(1)).toString(dateFormat: AppConstants.coinAPITimeFormat)
        }
        coin.historialOHLCVData(symbol: currency?.assetId ?? AppConstants.defaultCurrency, convert: Defaults.localCurrency, interval: unit.rawValue, timeStart: startTime, timeEnd: "") { (model, error) in
            if let data = model?.history?.quotes, data.count > 1 {
                self.updateGraph?(data)
            }
        }
    }
}

enum FilterUnit: String {
    case hour = "5m"
    case day = "1h"
    case week = "12h"
    case month = "2d"
    case quarter = "7d"
}
