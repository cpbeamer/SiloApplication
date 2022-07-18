//
//  UserProfileDetailsItems.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

protocol UserProfileDetailsItems {
    var kind: UserProfileDetailsKind { get }
}

enum UserProfileDetailsKind {
    case noData
    case transaction
}

extension UserProfileDetailsViewController {
    
    struct NoDataItem: UserProfileDetailsItems {
        let kind: UserProfileDetailsKind = .noData
        var title: String
    }
    
    struct TransactionItem: UserProfileDetailsItems {
        let kind: UserProfileDetailsKind = .transaction
        var refNo: String
        var assetId: String
        var cryptoAmount: String
        var date: String
        var fiatCurrency: String
        var fiatCurrencyAmount: String
    }
}
