//
//  APIResponseType.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

enum APIResponseType: String {
    
    case userNameNotInUse = "USER_NAME_NOT_IN_USE"
    case userNameAlredyRegister = "USER_NAME_ALREADY_REGISTERED"
    case mobileNumAlreadyRegisted = "PHONE_NO_ALREADY_REGISTERED"
    case userNameNotRegisted = "USERNAME_NOT_REGISTERED"
    case invalidCredential = "INCORRECT_EMAIL/PASSWORD"
    case forgotPassword = "FORGOT_PASSWORD"
    case userCreated = "USER_CREATED"
    case phoneAlreadyVerified = "PHONE_ALREADY_VERIFIED"
    
    var message: String? {
        switch self.rawValue {
        case APIResponseType.userNameNotInUse.rawValue:
            return ""
        case APIResponseType.userNameAlredyRegister.rawValue:
            return "Already Taken"
        case APIResponseType.mobileNumAlreadyRegisted.rawValue:
            return "Entered mobile number is already registered."
        case APIResponseType.userNameNotRegisted.rawValue:
            return "User Name is not registered with us."
        case APIResponseType.invalidCredential.rawValue:
            return "The password you have entered is incorrect."
        case APIResponseType.forgotPassword.rawValue:
            return "OTP sent successfully."
        case APIResponseType.userCreated.rawValue:
            return "Your account has been created successfully."
        default:
            return nil
        }
    }
    
}

enum ApiCode {
    static var success                  : Int { return 200 }    // Success
    static var unauthorizedRequest      : Int { return 206 }    // Unauthorized request
    static var headerMissing            : Int { return 207 }    // Header is missing
    static var phoneNumberAlreadyExist  : Int { return 208 }    // Phone number alredy exists
    static var requiredParametersMissing: Int { return 418 }    // Required Parameter Missing or Invalid
    static var fileUploadFailed         : Int { return 421 }    // File Upload Failed
    static var pleaseTryAgain           : Int { return 500 }    // Please try again
    static var tokenExpired             : Int { return 401 }    // Token expired refresh token needed to be generated
    static var noNetwork                : Int { return -1009}   // No internet connection
    static var blocked                  : Int { return 403}     // User blocked by Admin
    static var requestedUserBlocked     : Int { return 405}     // Requested user blocked by admin
    static var sessionExpired           : Int { return 440}     // Session expired
}
