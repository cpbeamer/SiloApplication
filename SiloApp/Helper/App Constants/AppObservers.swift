//
//  AppObservers.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

extension NotificationCenter {
    static var contactsSynced = NSNotification.Name(rawValue: "ContactsSynced")
    static var updateCruptoCurrencies = NSNotification.Name(rawValue: "UpdateCruptoCurrencies")
}
