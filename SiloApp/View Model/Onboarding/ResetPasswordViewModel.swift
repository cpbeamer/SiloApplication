//
//  ResetPasswordViewModel.swift
//  SiloApp
//
//  Created by Cary Beam on 7/20/22.
//

import UIKit

class ResetPasswordViewModel: NSObject {
    
    private (set) var service: WebServices
    var showAlertMessage: ((String) -> ())?
    var isPasswordReset: ((Bool) -> ())?
    
    override init() {
        self.service = WebServices()
    }
    
    func resetPassword(params: JSONDictionary) {
        service.resetPassword(params: params) { (model: OTPVerificationData?) in
            if let model = model, model.statusCode == ApiCode.success {
                self.isPasswordReset?(true)
            }
            self.showAlertMessage?(model?.message ?? AppStrings.somethingWentWrong.localized)
        } failure: { (_, errorData) in
            self.showAlertMessage?(errorData?.message ?? AppStrings.somethingWentWrong.localized)
        }
    }
}
