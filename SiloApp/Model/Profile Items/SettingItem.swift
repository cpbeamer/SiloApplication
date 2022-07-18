//
//  SettingItem.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import UIKit

struct SettingItem {
    var title: String
    var description: String
    var image: UIImage?
    var type: SettingItemType
    var isBoolType: Bool
}

enum SettingItemType {
    case enableNotification
    case restore
    case viewBackupPhrase
    case enablePasscode
    case enableFaceId
    case changePin
    case changePassword
}
