//
//  SwiftUIView.swift
//  SiloApp
//
//  Created by Cary Beam on 7/20/22.
//

import UIKit

class AddExternalWalletViewModel: NSObject {
    
    private (set) var service: WebServices
    var showAlertMessage: ((String) -> ())?
    var walletAdded: ((String) -> ())?

    override init() {
        self.service = WebServices()
    }
    
    func addExternalWallet(params: JSONDictionary) {
        service.addExternalWallet(params: params) { (model: CommonResponseData?) in
            if let model = model, model.statusCode == ApiCode.success {
                self.walletAdded?(model.message ?? "Wallet Added successfully!!!")
            }
        } failure: { (_, errorData) in
            self.showAlertMessage?(errorData?.message ?? AppStrings.somethingWentWrong.localized)
        }
    }
    
}
