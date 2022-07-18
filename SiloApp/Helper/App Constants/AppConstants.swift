//
//  AppConstants.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

import UIKit

struct AppConstants {
    static let padding: CGFloat = 20
    static let cornerRadius: CGFloat = 10
    static let requestCountLimit = 20
    static let backgroundTimerLimit: Double = 60
    static let resendTimerLimit = 60
    static let awsPoolId = "us-east-1:b1f250f2-66a7-4d07-96e9-01817149a439"
    static let coinMarketCapAPIKey = "24f60fd4-d69e-46f0-8c97-c0781ed3208c"

    #if DEV
    static let coinAPIKey = "84551146-DCFD-4D33-B809-E78B5E5AD385"
    #elseif QA
    static let coinAPIKey = "74DA087A-C102-4C73-9703-256AF853128C"
    #elseif STAGING
    static let coinAPIKey = "855D84C9-E879-4E01-93F0-C18F1AC09B9B"
    #else
    static let coinAPIKey = "AF9BA502-851C-4CA4-A6EA-AFC74243FE3A"
    #endif
    
    static let defaultCurrency = "USD"
//    static let coinAPITimeFormat = "yyyy-MM-ddTHH:mm:ss.fffffff"
    static let coinAPITimeFormat = "yyyy-MM-ddTHH:mm:ss.ffff"
    static var supportedCryptoCurrency: [SupporedCurrencyModel] = []
    static var supportedLocalCurrency: [SupporedCurrencyModel] = []
    static let maxFileSizeInBytes = 1048576//2097152
    static let maxKYCFileSizeInBytes = 7*1048576//2097152
}


/*
 user: akash
 password: Akash123
 phrase: "advice glass trial bless step turn divorce digital hungry junior spot flee"
 phrase qa: "bachelor quit stool hockey bar rocket sibling scale output dwarf sort spread"
 pin: 123456
 */

/*
 user: test
 password: Test1234
 phrase: "enlist submit inhale frown shallow crop duty brother exhibit wage select apple"
 pin: 123456
 */

