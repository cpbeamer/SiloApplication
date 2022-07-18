//
//  SellBuySendRequestItem.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

extension SellBuySendRequestViewController {
    enum SelectionKind {
        case sell
        case buy
        case send
        case request
    }
}

enum SectionItemKind {
    case add
    case normal
}

protocol SellBuySendRequestSectionItem {
    var kind: SectionItemKind { get }
    var items: [SellBuySendRequestItem] { get set}
}

class AddSectionItem: SellBuySendRequestSectionItem {
    var kind: SectionItemKind = .add
    var title: String
    var showAddBtn: Bool {
        return items.count > 2 ? false:true
    }
    var showAddWithPaste: Bool {
        return ((items.first as? EmptyBlock)?.isAddEnable ?? false) ? true:false
    }
    var items: [SellBuySendRequestItem] = []
    
    init(title: String) {
        self.title = title
    }
}

class DefaultSectionItem: SellBuySendRequestSectionItem {
    var kind: SectionItemKind = .normal
    var items: [SellBuySendRequestItem] = []
}

protocol SellBuySendRequestItem {
    var kind: ItemKind { get }
}

enum ItemKind {
    case showValue
    case amountConversion
    case selection
    case advanced
    case emptyBlock
    case addedUser
}

class CurrencyAmount: SellBuySendRequestItem {
    
    enum AmountType {
        case local
        case ctypto
    }
    
    let kind: ItemKind = .showValue
    var key: String
    var value: String
    var type: AmountType
    
    init(key: String, value: String, type: AmountType) {
        self.key = key
        self.value = value
        self.type = type
    }
}

class AmountConversion: SellBuySendRequestItem {
    
    let kind: ItemKind = .amountConversion
    var description: String
    var firstKey: String
    var firstPlaceholder: String
    var firstValue: String
    var secondKey: String
    var secondPlaceholder: String
    var secondValue: String
    var showSegments: Bool
    
    func updateKey(_ key: String) {
        if firstKey == Defaults.localCurrency {
            secondKey = key
        } else {
            firstKey = key
        }
    }
    
    init(description: String, firstKey: String, firstPlaceholder: String, firstValue: String, secondKey: String, secondPlaceholder: String, secondValue: String, showSegments: Bool = false) {
        self.description = description
        self.firstKey = firstKey
        self.firstPlaceholder = firstPlaceholder
        self.firstValue = firstValue
        self.secondKey = secondKey
        self.secondPlaceholder = secondPlaceholder
        self.secondValue = secondValue
        self.showSegments = showSegments
    }
}

class SelectedOption: SellBuySendRequestItem {
    
    let kind: ItemKind = .selection
    var title: String
    var placeholder: String
    var value: String = ""
    
    init(title: String, placeholder: String) {
        self.title = title
        self.placeholder = placeholder
    }
}

class AdvancedOption: SellBuySendRequestItem {
    
    let kind: ItemKind = .advanced
    var isEnable: Bool
    var value: String
    
    init(isEnable: Bool, value: String) {
        self.isEnable = isEnable
        self.value = value
    }
}

class EmptyBlock: SellBuySendRequestItem {
    
    let kind: ItemKind = .emptyBlock
    let isAddEnable: Bool
    var message: String
    
    init(message: String, isAddEnable: Bool) {
        self.message = message
        self.isAddEnable = isAddEnable
    }
}

class AddedUserDetails: SellBuySendRequestItem {
    
    let kind: ItemKind = .addedUser
    var user: AppUser
    
    init(user: AppUser) {
        self.user = user
    }
}
