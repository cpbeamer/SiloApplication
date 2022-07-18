//
//  ReviewDetailsItem.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation


protocol ReviewDetailsItems {
    var kind: ReviewDetailsKind { get }
}

enum ReviewDetailsKind {
    case user
    case amount
    case totalAmount
    case exchangeItem
    case field
}

class ReviewDetailsUser: ReviewDetailsItems {
    
    let kind: ReviewDetailsKind = .user
    var user: AppUser
    
    init(user: AppUser) {
        self.user = user
    }
}

class ReviewDetailsAmount: ReviewDetailsItems {
    
    enum AmountType {
        case local
        case crypto
    }
    
    let kind: ReviewDetailsKind = .amount
    var key: String
    var value: String
    var type: AmountType
    
    init(key: String, value: String, type: AmountType) {
        self.key = key
        self.value = value
        self.type = type
    }
}

class ReviewDetailsTotalAmount: ReviewDetailsItems {
    
    let kind: ReviewDetailsKind = .totalAmount
    var amount: String
    var key: String
    var description: String
    
    init(amount: String, key: String, description: String) {
        self.amount = amount
        self.key = key
        self.description = description
    }
}

class ReviewExchangeDetailsItem: ReviewDetailsItems {
    
    enum ExchangeType {
        case send
        case receive
    }
    
    let kind: ReviewDetailsKind = .exchangeItem
    var cryptoCurrency: SupporedCurrencyModel
    var cryptoCurrenyAmount: String
    var localCurrenyAmount: String
    var type: ExchangeType
    
    init(cryptoCurrency: SupporedCurrencyModel, cryptoCurrenyAmount: String, localCurrenyAmount: String, type: ExchangeType) {
        self.cryptoCurrency = cryptoCurrency
        self.cryptoCurrenyAmount = cryptoCurrenyAmount
        self.localCurrenyAmount = localCurrenyAmount
        self.type = type
    }
}

class ReviewDetails: ReviewDetailsItems {
    
    let kind: ReviewDetailsKind = .field
    var key: String
    var name: String
    var value: String
    
    init(key: String, name: String, value: String) {
        self.key = key
        self.name = name
        self.value = value
    }
}
