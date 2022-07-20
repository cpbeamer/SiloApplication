//
//  OTPVerificationViewModel.swift
//  SiloApp
//
//  Created by Cary Beam on 7/20/22.
//

import UIKit

class OTPVerificationViewModel: NSObject {
    
    private (set) var service: WebServices
    var showAlertMessage: ((String) -> ())?
    var sentOTP: ((ForgotPasswordData) -> ())?
    var alreadyVerified: ((String?) -> ())?
    var otpVerified: ((Bool) -> ())?
    
    override init() {
        self.service = WebServices()
    }
    
    func resendOTP(params: JSONDictionary) {
        service.sentOTP(params: params) { (model: ForgotPasswordData?) in
            if let model = model, model.otp != nil {
                self.sentOTP?(model)
            }
            self.showAlertMessage?(model?.message ?? AppStrings.somethingWentWrong.localized)
        } failure: { (_, errorData) in
            let code = APIResponseType(rawValue: errorData?.type ?? "")
            if code == .phoneAlreadyVerified {
                self.alreadyVerified?(errorData?.message)
            } else {
                self.showAlertMessage?(errorData?.message ?? AppStrings.somethingWentWrong.localized)
            }
        }
    }
    
    func sendOTPForRegisterarion(params: JSONDictionary) {
        service.sendOTPForRegisterarion(params: params) { (model: ForgotPasswordData?) in
            if let model = model, model.otp != nil {
                self.sentOTP?(model)
            }
            self.showAlertMessage?(model?.message ?? AppStrings.somethingWentWrong.localized)
        } failure: { (_, errorData) in
            let code = APIResponseType(rawValue: errorData?.type ?? "")
            if code == .phoneAlreadyVerified {
                self.alreadyVerified?(errorData?.message)
            } else {
                self.showAlertMessage?(errorData?.message ?? AppStrings.somethingWentWrong.localized)
            }
        }
    }
    
    func verifyOTP(params: JSONDictionary) {
        service.verifyOTP(params: params) { (model: OTPVerificationData?) in
            if let model = model, model.statusCode == ApiCode.success {
                self.otpVerified?(true)
            } else {
                self.showAlertMessage?(model?.message ?? AppStrings.somethingWentWrong.localized)
            }
        } failure: { (_, errorData) in
            self.showAlertMessage?(errorData?.message ?? AppStrings.somethingWentWrong.localized)
        }
    }
}
