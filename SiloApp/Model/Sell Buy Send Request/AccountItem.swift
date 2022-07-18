//
//  AccountItem.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct AccountItem {
    enum AccountItemKind {
        case kycStatus
        case card
        case bank
        case addItem
    }
    
    var kind: AccountItemKind
    var id: String?
    var name: String
    var value: String
    var image: UIImage?
    var isSelected = false
    
    mutating func updateSelection(_ value: Bool) {
        self.isSelected = value
    }
}
