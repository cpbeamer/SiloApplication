//
//  LoginViewModel.swift
//  SiloApp
//
//  Created by Cary Beam on 7/20/22.
//

import UIKit

class LoginViewModel: NSObject {
    
    private (set) var service: WebServices
    var showAlertMessage: ((String) -> ())?
    var loggedInData: ((UserData) -> ())?
    
    override init() {
        self.service = WebServices()
    }
    
    func loginUser(params: JSONDictionary) {
        service.login(params: params) { (model: UserData?) in
            if let model = model, let token = model.authToken {
                self.loggedInData?(model)
                Defaults.authToken = token
                Defaults.loggedInUser = model
            } else {
                self.showAlertMessage?(model?.message ?? AppStrings.somethingWentWrong.localized)
            }
        } failure: { (_, errorData) in
            self.showAlertMessage?(errorData?.message ?? AppStrings.somethingWentWrong.localized)
        }
    }
}
