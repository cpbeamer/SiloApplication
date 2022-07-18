//
//  EndPoints.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import UIKit

//MARK:- API URLS
//==============
enum URLs {
    
    private static let distributionUrl = "http://cryptostgapi.appskeeper.in"
    private static let devUrl = "http://cryptodevapi.appskeeper.in"
    private static let stagingUrl = "http://cryptostgapi.appskeeper.in"
    private static let qaURl = "http://cryptoqaapi.appskeeper.in"
    
    #if DEV
    static let hostURL = devUrl
    #elseif QA
    static let hostURL = qaURl
    #elseif STAGING
    static let hostURL = stagingUrl
    #else
    static let hostURL = distributionUrl
    #endif
    
    static let baseURL: String = hostURL + "/api/v1"
}

//MARK:- API_ENDPOINTS
//======================
extension NetworkManager {
    
    enum EndPoint : String {
        //User APIs
        case userNameExist              = "/user/check-username-exist"
        case signup                     = "/user/sign-up"
        case login                      = "/user/login"
        case forgotPassword             = "/user/forgot-password"
        case phoneVerification          = "/user/phone-verification"
        case verifyOTP                  = "/user/verify-otp"
        case resetPassword              = "/user/reset-password"
        case addCryptoCurrencies        = "/user/add-crypto-currencies"
        case updateRecoveryPhrase       = "/user/update-recovery-phase"
        case getRecoveryPhrase          = "/user/get-recovery-phase"
        case logout                     = "/user/logout"
        case editProfile                = "/user/edit-profile"
        case getOwnProfileData          = "/user/profile"
        case contactSync                = "/contact/contact-sync"
        case deleteContact              = "/user/delete-contact"
        case contactList                = "/user/contacts-listing"
        case searchUser                 = "/user/search"
        case addFriend                  = "/contact/add-friend"
        case unFriend                   = "/user/unfriend-contact"
        case userProfileDetails         = "/user/view-profile"
        case contactUs                  = "/user/contact-admin"
        case changePassword             = "/user/update-password"
        case addExternalWallet          = "/user/add-external-wallet"
        case externalWalletList         = "/user/wallet-listing"
        case sendTransferRequest        = "/transactions/send-request"
        case getTransferRequests        = "/transactions/requests-listing"
        case notificationList           = "/user/notifications"
        case clearNotifications         = "/user/clear-notifications"
        case declineRequest             = "/transactions/decline-request"
        case getWalletBalance           = "/user/get-wallet-balance"
        case getSettings                = "/user/settings"
        case updateSettings             = "/user/update-settings"
        case transactionHistory         = "/transactions/transaction-history"
        
        //Wyre APIs
        case uploadWyreDoc              = "/wyre/upload-document"
        case wyreDocVerification        = "/wyre/document-verify"
        case getWyreAccountDetails      = "/wyre/get-user-account"
        case getWyrePaymnetMethods      = "/wyre/list-payment-methods"
        case addWyreBankAccount         = "/wyre/add-bank-account"
        case deleteWyrePaymnetMethod    = "/wyre/delete-payment-method"
        case createBuyTransferRequest   = "/wyre/create-transfer"
        case buyConfirmTransfer         = "/wyre/confirm-transfer"
        case uploadBankDocument         = "/wyre/upload/bank-document"
        case getSupportedCountries      = "/wyre/supported-countries"
        case updateAccount              = "/wyre/update-account"
        case getCardOrderQuotations     = "/wyre/debit-card/order-quotations"
        case reserveCardPurchase        = "/wyre/debit-card/reserve"
        case cardTransferProcessing     = "/wyre/debit-card-processing"
        case cardOrderAuthorization     = "/wyre/debit-card/authorization"
        
        func path(_ params: [String] = []) -> String {
            let url = URLs.baseURL
            var rawValue = self.rawValue
            for item in params {
                rawValue += "/\(item)"
            }
            return url + rawValue
        }
    }
    
    class UploadFileFormat {
        var fileKey: String
        var fileName: String
        var fileData: Data
        var isUploaded = false
        
        init(fileKey: String, fileName: String, fileData: Data, isUploaded: Bool = false) {
            self.fileKey = fileKey
            self.fileName = fileName
            self.fileData = fileData
            self.isUploaded = isUploaded
        }
    }
}
