//
//  WebServices.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct WebServices {
    
    var network: NetworkManager
    
    init() {
        self.network = NetworkManager()
    }
    
    func login<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .login) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func checkUserName<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .get, endPoint: .userNameExist, loader: false) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func signUp<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .signup) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func sentOTP<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .forgotPassword) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func sendOTPForRegisterarion<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .phoneVerification) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func verifyOTP<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .verifyOTP) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func resetPassword<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .patch, endPoint: .resetPassword) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func updateCurrecy<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .addCryptoCurrencies) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func updateRecoveryPhrase<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .patch, endPoint: .updateRecoveryPhrase) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func getCurrentUserRecoveryPhrase<T>(success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [:], method: .get, endPoint: .getRecoveryPhrase) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func logout<T>(success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [:], method: .post, endPoint: .logout) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func updateProfile<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .patch, endPoint: .editProfile){ (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func getOwnProfileData<T>(success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [:], method: .get, endPoint: .getOwnProfileData){ (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func contactSyncWithServer<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .contactSync, loader: false){ (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func deleteContactFromServer<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .patch, endPoint: .deleteContact, loader: false){ (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func contactList<T>(params: JSONDictionary, loader: Bool, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .get, endPoint: .contactList, loader: loader){ (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func searchUsers<T>(params: JSONDictionary, loader: Bool, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .get, endPoint: .searchUser, loader: loader){ (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func addFriend<T>(userId: String, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [:], extraURLComponents: [userId], method: .post, endPoint: .addFriend) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func unFriend<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .patch, endPoint: .unFriend) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func userProfileDetails<T>(userId: String, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [:], extraURLComponents: [userId], method: .post, endPoint: .userProfileDetails) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func sendConatactUsMesssage<T>(msg: String, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [ApiKey.message: msg], method: .post, endPoint: .contactUs) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func changePassword<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .patch, endPoint: .changePassword) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func addExternalWallet<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .addExternalWallet) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func externalWalletList<T>(params: JSONDictionary, loader: Bool, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .get, endPoint: .externalWalletList, loader: loader){ (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func sendTransferRequest<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .sendTransferRequest) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func getTransferRequests<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .get, endPoint: .getTransferRequests) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func getNotificationList<T>(params: JSONDictionary, loader: Bool, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .get, endPoint: .notificationList, loader: loader) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func clearAllNotifications<T>(success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [:], method: .patch, endPoint: .clearNotifications) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func declineRequest<T>(requestId: String, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [ApiKey.requestId: requestId], method: .patch, endPoint: .declineRequest) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func getWalletBalance<T>(addresses: JSONDictionary, loader: Bool, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: addresses, method: .get, endPoint: .getWalletBalance, loader: loader) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func uploadKYCDocuments<T>(params: JSONDictionary, files: [NetworkManager.UploadFileFormat]?, loader: Bool, progress : @escaping (Double) -> Void , success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.uploadFilesRequest(params: params, endPoint: .wyreDocVerification, files: files, loader: loader, progress: progress, success: success, failure: failure)
    }
    
    func getWyreAccountDetails<T>(wyreAccountId: String, loader: Bool, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [ApiKey.accountId: wyreAccountId], method: .get, endPoint: .getWyreAccountDetails, loader: loader) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func getWyrePaymnetMethods<T>(wyreAccountId: String, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [ApiKey.accountId: wyreAccountId], method: .get, endPoint: .getWyrePaymnetMethods) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func addWyreBankAccount<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .addWyreBankAccount) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func deleteWyrePaymnetMethod<T>(wyreAccountId: String, paymentMethodId: String, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [ApiKey.accountId: wyreAccountId], extraURLComponents: [paymentMethodId], method: .delete, endPoint: .deleteWyrePaymnetMethod) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func getSettings<T>(success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [:], method: .get, endPoint: .getSettings) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func updateSettings<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .patch, endPoint: .updateSettings) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func createBuyTransferRequest<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .createBuyTransferRequest) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func buyConfirmTransfer<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .buyConfirmTransfer) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func uploadBankDocument<T>(wyreAccountId: String, paymentMethodId: String, files: [NetworkManager.UploadFileFormat]?, progress : @escaping (Double) -> Void , success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        var params: JSONDictionary = [:]
        params[ApiKey.accountId] = wyreAccountId
        params[ApiKey.paymentMethodId] = paymentMethodId
        network.uploadFilesRequest(params: params, endPoint: .uploadBankDocument, files: files, progress: progress, success: success, failure: failure)
    }
    
    func getSupportedCountries<T>(success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [:], method: .get, endPoint: .getSupportedCountries) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func updateAccount<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .updateAccount) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func getCardOrderQuotations<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .getCardOrderQuotations) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func reserveCardPurchase<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .reserveCardPurchase) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func cardTransferProcessing<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .cardTransferProcessing) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func getCardOrderAuthorization<T>(orderId: String, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: [:], extraURLComponents: [orderId], method: .get, endPoint: .cardOrderAuthorization) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func cardOrderAuthorization<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .post, endPoint: .cardOrderAuthorization) { (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
    
    func getTransactionHistory<T>(params: JSONDictionary, success : @escaping (T?) -> Void, failure : @escaping (Error, ErrorData?) -> Void) where T: Codable {
        network.request(params: params, method: .get, endPoint: .transactionHistory){ (model: T?) in
            success(model)
        } failure: { (error, errorData) in
            failure(error, errorData)
        }
    }
}
