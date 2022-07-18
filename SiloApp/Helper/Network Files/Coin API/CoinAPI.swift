//
//  CoinAPI.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

/*
 Thank you for your interest in CoinAPI services.
 API Key: 84551146-DCFD-4D33-B809-E78B5E5AD385
 API Key: 74DA087A-C102-4C73-9703-256AF853128C
 API Key: AF9BA502-851C-4CA4-A6EA-AFC74243FE3A
 Products: Free
 Several resources can be useful to you:
 * API Documentation: https://docs.coinapi.io/
 * API SDK: https://github.com/coinapi/coinapi-sdk
 * FAQ: https://www.coinapi.io/faq
 By accessing and using the CoinAPI Services, you accept, these Terms of Use available at https://www.coinapi.io/legal#terms
 We hope that you will find everything you need in our services and subscribe to paid plan!
 If you have any requests, then you can raise them in the Support Center available at https://www.coinapi.io/support
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 WWW.COINAPI.IO · COINAPI LTD
 SUITE 208 BRITANNIA HOUSE · 1-11 GLENTHORNE ROAD
 LONDON · W6 0LH · UNITED KINGDOM
 */

import Foundation

/** BASE API URL **/
fileprivate let COINAPI_URL     = "https://rest.coinapi.io"
/** HEADER NAME **/
fileprivate let HEADER_API_KEY = "X-CoinAPI-Key"

/** Handler block **/
typealias APIResponse = ((_ response: AnyObject?, _ error: Error?) -> Void)

/** Error Handler **/
enum CoinAPIError: Error {
    case invalidRequest
    case invalidJSON
    case unknown
}

/** Metadata Functions **/
protocol MetadataProtocol {
    func metadataExchanges(completionHandler: @escaping APIResponse)
    func metadataAssets(currencies: [String]?, completionHandler: @escaping APIResponse)
    func metadataSymbols(completionHandler: @escaping APIResponse)
}

/** Exchange Rates Functions **/
protocol ExchangeRatesProtocol {
    func exchangeRatesBy(assetId base: String, idQuote: String, time: String, completionHandler: @escaping APIResponse)
    func allExchangeRatesBy(assetId base: String, completionHandler: @escaping APIResponse)
}

/** Open, High, Low, Close Prices and Volume indicators Functions **/
protocol OHLCVDataProtocol {
    func allOHLCVPeriods(completionHandler: @escaping APIResponse)
    func latestOHLCVData(symbol id: String, periodId: String, limit: Int, completionHandler: @escaping APIResponse)
    func historialOHLCVData(symbol id: String, periodId: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse)
}

/** Trades Functions **/
protocol TradesDataProtocol {
    func latestTradesData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse)
    func historicalTradesData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse)
}

/** Quotes Functions **/
protocol QuotesDataProtocol {
    func currentQuotesData(symbol id: String, completionHandler: @escaping APIResponse)
    func latestQuotesData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse)
    func historicalQuotesData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse)
}

/** Orderbooks Functions **/
protocol OrderbooksDataProtocol {
    func currentOrderBooksData(symbol id: String, completionHandler: @escaping APIResponse)
    func latestOrderBooksData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse)
    func historicalOrderBooksData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse)
}

/*
 * CoinAPI Class
 **/
class CoinAPI {
    
    private (set) var apiKey: String
    
    init(apiKey key: String) {
        self.apiKey = key
    }
    
    /*
     * Perform URLRequest and return data based on the API response.
     **/
    private func perform(request _request: URLRequest, completionHandler: @escaping APIResponse) {
        CommonFunctions.showActivityLoader()
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: _request) { (data: Data?, response: URLResponse?, error: Error?) in
            CommonFunctions.hideActivityLoader()
            guard let responseData = data else {
                completionHandler(nil, CoinAPIError.unknown)
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as AnyObject
                if let error = jsonResponse["error"] as? String, error.lowercased().contains(s: "too many request") {
                    let request = NSMutableURLRequest(url: _request.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
                    request.httpMethod = _request.httpMethod!
                    self.apiKey = "AF9BA502-851C-4CA4-A6EA-AFC74243FE3A"
                    request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
                    self.perform(request: request as URLRequest, completionHandler: completionHandler)
                } else {
                    completionHandler(jsonResponse, nil)
                }
            } catch {
                completionHandler(nil, CoinAPIError.invalidJSON)
            }
            
        }
        
        task.resume()
    }
}

// MARK: - Metadata Implementation
extension CoinAPI: MetadataProtocol {
    
    func metadataExchanges(completionHandler: @escaping APIResponse) {
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/exchanges")) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
    func metadataAssets(currencies: [String]? = nil, completionHandler: @escaping APIResponse) {
//        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/assets")) else {
//            completionHandler(nil, CoinAPIError.invalidRequest)
//            return
//        }
//        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/assets?filter_asset_id=BTC;ETH")) else {
//            completionHandler(nil, CoinAPIError.invalidRequest)
//            return
//        }
        let allCurrencies = AppConstants.supportedCryptoCurrency.map({$0.assetId})
        let data = (currencies?.count ?? 0) > 0 ? (currencies ?? allCurrencies) : allCurrencies
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/assets?filter_asset_id=\(data.joined(separator: ","))")) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
    func assetsIcon(completionHandler: @escaping APIResponse) {
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/assets/icons/20")) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
    func metadataSymbols(completionHandler: @escaping APIResponse) {
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/symbols")) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
}

// MARK: - Metadata Implementation
extension CoinAPI: ExchangeRatesProtocol {
    
    func exchangeRatesBy(assetId base: String, idQuote: String, time: String, completionHandler: @escaping APIResponse) {
        // build URI string
        var requestResource = "/v1/exchangerate/\(base)/\(idQuote)"
        if time != "" {
            requestResource = "/v1/exchangerate/\(base)/\(idQuote)?time=\(time)"
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
    func allExchangeRatesBy(assetId base: String, completionHandler: @escaping APIResponse) {
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/exchangerate/\(base)?invert=true")) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
}

// MARK: - OHLCV Implementation
extension CoinAPI: OHLCVDataProtocol {
    
    func allOHLCVPeriods(completionHandler: @escaping APIResponse) {
        guard let requestUrl = URL(string: COINAPI_URL.appending("/v1/ohlcv/periods")) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
    func latestOHLCVData(symbol id: String, periodId: String, limit: Int, completionHandler: @escaping APIResponse) {
        // build URI string
        var requestResource = "/v1/ohlcv/\(id)/latest?period_id=\(periodId)"
        if limit > 0 {
            requestResource = "/v1/ohlcv/\(id)/latest?period_id=\(periodId)&limit=\(limit)"
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
    func historialOHLCVData(symbol id: String, periodId: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse) {
        // build URI string
        var requestResource = "/v1/ohlcv/\(id)/latest?period_id=\(periodId)&time_start=\(timeStart)"
        
        if !timeEnd.isEmpty {
            requestResource.append("&time_end=\(timeEnd)")
        }
        if limit > 0 {
            requestResource.append("&limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
}

// MARK: - Trades Implementation
extension CoinAPI: TradesDataProtocol {
    
    func latestTradesData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse) {
        // build URI string
        var requestResource = "/v1/trades/latest"
        
        if !id.isEmpty {
            requestResource.append("trades/\(id)/latest")
        }
        if limit > 0 {
            requestResource.append("?limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
    func historicalTradesData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse) {
        // build URI string
        var requestResource = "/v1/trades/\(id)/history?time_start=\(timeStart)"
        
        if !timeEnd.isEmpty {
            requestResource.append("&time_end=\(timeEnd)")
        }
        if limit > 0 {
            requestResource.append("&limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
}

// MARK: - Quotes Implementation
extension CoinAPI: QuotesDataProtocol {
    
    func currentQuotesData(symbol id: String, completionHandler: @escaping APIResponse) {
        // build URI string
        var requestResource = "/v1/quotes/current"
        
        if !id.isEmpty {
            requestResource.append("/v1/quotes/\(id)/current")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
    func latestQuotesData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse) {
        // build URI string
        var requestResource = "/v1/quotes/latest"
        
        if !id.isEmpty {
            requestResource = "/v1/quotes/\(id)/latest"
        }
        if limit > 0 {
            requestResource.append("?limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
    func historicalQuotesData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse) {
        // build URI string
        var requestResource = "/v1/quotes/\(id)/history?time_start=\(timeStart)"
        
        if !timeEnd.isEmpty {
            requestResource.append("&time_end=\(timeEnd)")
        }
        if limit > 0 {
            requestResource.append("&limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
}

// MARK: - Order Books Implementation
extension CoinAPI: OrderbooksDataProtocol {
    
    func currentOrderBooksData(symbol id: String, completionHandler: @escaping APIResponse) {
        // build URI string
        var requestResource = "/v1/orderbooks/current"
        
        if !id.isEmpty {
            requestResource.append("/v1/orderbooks/\(id)/current")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
    func latestOrderBooksData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse) {
        // build URI string
        var requestResource = "/v1/orderbooks/\(id)/latest"
        
        if limit > 0 {
            requestResource.append("?limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
    func historicalOrderBooksData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse) {
        // build URI string
        var requestResource = "/v1/quotes/\(id)/history?time_start=\(timeStart)"
        
        if !timeEnd.isEmpty {
            requestResource.append("&time_end=\(timeEnd)")
        }
        if limit > 0 {
            requestResource.append("&limit=\(limit)")
        }
        
        guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, completionHandler: completionHandler)
    }
    
}
