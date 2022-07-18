//
//  ProfileItem.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import UIKit

struct ProfileSectionItem {
    var title: String
    var items: [ProfileItem]
    var type: ProfileSectionItemType
}

enum ProfileSectionItemType {
    case header
    case content
}

struct ProfileItem {
    var title: String
    var image: UIImage?
    var type: ProfileItemType
}

enum ProfileItemType {
    case userInfo
    case searchUser
    case notification
    case transactionHistory
    case paymentMethods
    case friends
    case requests
    case assets
    case security
    case settings
    case contactUs
    case logout
    case privacyTerms
}
