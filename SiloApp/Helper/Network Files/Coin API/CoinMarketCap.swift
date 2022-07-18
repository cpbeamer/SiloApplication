//
//  CoinMarketCap.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

/** BASE API URL **/
fileprivate let COINAPI_URL     = "https://pro-api.coinmarketcap.com"
/** HEADER NAME **/
fileprivate let HEADER_API_KEY = "X-CMC_PRO_API_KEY"//"X-CoinAPI-Key"
/** Error Handler **/
enum CoinMarketCapError: Error {
    case invalidRequest
    case invalidJSON
    case unknown
}

/** End Point Handler **/
enum CoinMarketEndPoint: String {
    case latestQuotes = "/v1/cryptocurrency/quotes/latest"
    case ohlcvHistorical = "/v1/cryptocurrency/quotes/historical"
    
    var path: String {
        return COINAPI_URL.appending(self.rawValue)
    }
}

/*
 * CoinMarketCap Class
 **/
class CoinMarketCap {
    
    private (set) var apiKey: String
    
    init(apiKey key: String) {
        self.apiKey = key
    }
    
    /*
     * Perform URLRequest and return data based on the API response.
     **/
    private func perform<T>(request _request: URLRequest, loader : Bool = true, completionHandler: @escaping (T?, Error?) -> Void) where T: Codable {
        if loader { CommonFunctions.showActivityLoader() }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: _request) { (data: Data?, response: URLResponse?, error: Error?) in
            if loader { CommonFunctions.hideActivityLoader() }
            guard let responseData = data else {
                if let error = error {
                    self.manageUnderlyingErrors(error: error)
                }
                completionHandler(nil, CoinMarketCapError.unknown)
                return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as AnyObject
                debugPrint(_request.url?.absoluteString as Any)
                debugPrint(jsonResponse)
//                let json = JSON(jsonResponse)
//                debugPrint(json)
                let data = try JSONDecoder().decode(T.self, from: responseData) //Decode JSON Response Data
                debugPrint(data)
                completionHandler(data, nil)
            } catch {
                debugPrint("Error------>", error)
                self.manageUnderlyingErrors(error: error)
                completionHandler(nil, CoinMarketCapError.invalidJSON)
            }
        }
        task.resume()
    }
    
    func manageUnderlyingErrors(error: Error) {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .timedOut:
                CommonFunctions.showToastWithMessage(AppStrings.requestTimeOut.localized)
            case .notConnectedToInternet:
                CommonFunctions.showToastWithMessage(AppStrings.pleaseCheckInternetConnection.localized)
            default:
                CommonFunctions.showToastWithMessage(AppStrings.somethingWentWrong.localized)
            }
        }
    }
}

// MARK: - CoinMarketCap API Implementation
extension CoinMarketCap {
    func exchangeRatesListBy(currencies: [String]?,
                             localCurrency convert: String = Defaults.localCurrency,
                             loader : Bool = true,
                             completionHandler: @escaping (CryptoCurrenciesData?, Error?) -> Void) {
        // build URI string
        guard let currencies = currencies else {
            debugPrint("Currencies value is nil")
            return
        }
        let symbols = currencies.joined(separator: ",")
        guard let requestUrl = URL(string: CoinMarketEndPoint.latestQuotes.path.appending("?symbol=\(symbols)&convert=\(convert)")) else {
            completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        
        // Build request
        let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        request.httpMethod = "GET"
        request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        // Perform request
        perform(request: request as URLRequest, loader: loader , completionHandler: completionHandler)
    }
    
    func historialOHLCVData(symbol: String, convert: String = Defaults.localCurrency, interval: String, timeStart: String = "", timeEnd:String = "", count: Int = 20, completionHandler: @escaping (CryptoHistoricalData?, Error?) -> Void) {
        // build URI string
        var requestResource = CoinMarketEndPoint.ohlcvHistorical.path.appending("?symbol=\(symbol)&convert=\(convert)")
        if !interval.isEmpty {
            requestResource.append("&interval=\(interval)")
        }
        if !timeStart.isEmpty {
            requestResource.append("&time_start=\(timeStart)")
        }
        if !timeEnd.isEmpty {
            requestResource.append("&time_end=\(timeEnd)")
        }
        if count > 0 {
            requestResource.append("&count=\(count)")
        }
        
        guard let requestUrl = URL(string: requestResource) else {
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
