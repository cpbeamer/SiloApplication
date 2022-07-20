//
//  ForgotPasswordViewModel.swift
//  SiloApp
//
//  Created by Cary Beam on 7/20/22.
//

import UIKit

class ForgotPasswordViewModel: NSObject {
    
    private (set) var service: WebServices
    var showAlertMessage: ((String) -> ())?
    var sentOTP: ((ForgotPasswordData) -> ())?
    
    override init() {
        self.service = WebServices()
    }
    
    func forgotPassword(params: JSONDictionary) {
        service.sentOTP(params: params) { (model: ForgotPasswordData?) in
            if let model = model, model.otp != nil {
                self.sentOTP?(model)
            }
            self.showAlertMessage?(model?.message ?? AppStrings.somethingWentWrong.localized)
        } failure: { (_, errorData) in
            self.showAlertMessage?(errorData?.message ?? AppStrings.somethingWentWrong.localized)
        }
    }
}
