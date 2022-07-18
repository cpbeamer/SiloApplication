//
//  AppDefaults.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

struct Defaults {
    enum Key: String {
        case isBiometricsEnable = "isBiometricsEnable"
        case isLoggedIn = "isLoggedIn"
        case openPasscodeWindow = "openPasscodeWindow"
        case isPasscodeEnable = "isPasscodeEnable"
        case authToken = "customerId"
        case loggedInUser = "loggedInUser"
        case localCurrency = "localCurrency"
        case isNotificationsEnable = "isNotificationsEnable"
        case isContactSynced = "isContactSynced"
        case language = "language"
        case deviceToken = "deviceToken"
        case moveToNotification = "moveToNotification"
    }
    
    private static let preserveValues: [Key] = [.deviceToken, .language, .isBiometricsEnable, .isPasscodeEnable]
    
    static func removeUnPreservedData() {
        for i in UserDefaults.standard.dictionaryRepresentation() {
            if let key = Defaults.Key(rawValue: i.key), preserveValues.contains(key) {
                debugPrint("Preserved-->",i.key)
            } else {
                debugPrint("Deleted-->",i.key)
                UserDefaults.standard.removeObject(forKey: i.key)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    static var isBiometricsEnable: Bool {
        get {
            let isBiometricsEnable = UserDefaults.standard.bool(forKey: Key.isBiometricsEnable.rawValue)
            return isBiometricsEnable
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.isBiometricsEnable.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isLoggedIn: Bool {
        get {
            let isLoggedIn = UserDefaults.standard.bool(forKey: Key.isLoggedIn.rawValue)
            return isLoggedIn
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.isLoggedIn.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var openPasscodeWindow: Bool {
        get {
            let openPasscodeWindow = UserDefaults.standard.bool(forKey: Key.openPasscodeWindow.rawValue)
            return openPasscodeWindow
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.openPasscodeWindow.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isPasscodeEnable: Bool {
        get {
            let isPasscodeEnable = UserDefaults.standard.bool(forKey: Key.isPasscodeEnable.rawValue)
            return isPasscodeEnable
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.isPasscodeEnable.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var authToken: String? {
        get {
            let authToken = UserDefaults.standard.string(forKey: Key.authToken.rawValue)
            return authToken
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.authToken.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var loggedInUser: UserData? {
        get {
            if let data = UserDefaults.standard.object(forKey: Key.loggedInUser.rawValue)  as? Data {
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(UserData.self, from: data)
                    return user
                } catch {
                    return nil
                }
            } else {
                return nil
            }
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: Key.loggedInUser.rawValue)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    static var localCurrency: String {
        get {
            let localCurrency = UserDefaults.standard.string(forKey: Key.localCurrency.rawValue)
            return localCurrency ?? AppConstants.defaultCurrency
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.localCurrency.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isNotificationsEnable: Bool {
        get {
            let isNotificationsEnable = UserDefaults.standard.bool(forKey: Key.isNotificationsEnable.rawValue)
            return isNotificationsEnable
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.isNotificationsEnable.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isContactSynced: Bool {
        get {
            let isContactSynced = UserDefaults.standard.bool(forKey: Key.isContactSynced.rawValue)
            return isContactSynced
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.isContactSynced.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var language: String? {
        get {
            let language = UserDefaults.standard.string(forKey: Key.language.rawValue)
            return language
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.language.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var deviceToken: String? {
        get {
            let deviceToken = UserDefaults.standard.string(forKey: Key.deviceToken.rawValue)
            return deviceToken
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.deviceToken.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var moveToNotification: Bool {
        get {
            let moveToNotification = UserDefaults.standard.bool(forKey: Key.moveToNotification.rawValue)
            return moveToNotification
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.moveToNotification.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
