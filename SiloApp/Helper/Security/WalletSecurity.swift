//
//  WalletSecurity.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import CommonCrypto
import CryptoKit
import WalletCore

// MARK:- Warning: Do not change the this object as it will be unique set for the users. Updating anything in this file may generate errors for the registed users and they will not able to recover their accounts.
enum WalletSecurity {
    
    private static let ciphertext = "ciphertext"
    private static let iv = "iv"
    private static let tag = "tag"
    
    static func combinePhrases(_ list: [String]) -> String {
        return list.joined(separator: " ")
    }
    
//    static func encryptAES(phrase: String, key: String) -> String? {
//        let aes = CustomAES(key: key)
//        let encryptedString = aes?.encrypt(string: phrase)
//        return encryptedString
//    }
    
//    static func decryptAES(encryptedString: String, key: String) -> String? {
//        let aes = CustomAES(key: key)
//        let decryptedString = aes?.decrypt(data: encryptedString)
//        return decryptedString
//    }
    
    //Encryption
    static func encrypt(phrase: String, salt: String?, password: String?, offset: Int?) -> String? {
        if let salt = salt, let password = password {
            let encryption = Encryption()
            if let key = encryption.optimisedPBKDF2Key(salt: salt, password: password, offset: offset) {
                let iv = encryption.generateIV(length: encryption.ivLength)
                if let encryptedObject = encryption.encryptAES(message: phrase, key: key, iv: iv) {
                    var dict: JSONDictionary = [:]
                    dict[WalletSecurity.ciphertext] = encryptedObject.ciphertext
                    dict[WalletSecurity.iv] = encryptedObject.iv
                    dict[WalletSecurity.tag] = encryptedObject.tag
                    let data = CommonFunctions.jsonToData(dict)
                    return data?.base64EncodedString()
                }
            }
        }
        return nil
    }
    
    //Decryption
    static func decrypt(encryptedPhrase: String, salt: String?, password: String?, offset: Int?) -> String? {
        if let json = CommonFunctions.dataToJson(Data(base64Encoded: encryptedPhrase)), let salt = salt, let password = password {
            if let ciphertext = json[WalletSecurity.ciphertext] as? String, let iv = json[WalletSecurity.iv] as? String, let tag = json[WalletSecurity.tag] as? String {
                let encryption = Encryption()
                let object = Encryption.EncryptedObject(ciphertext: ciphertext, iv: iv, tag: tag)
                if let key = encryption.optimisedPBKDF2Key(salt: salt, password: password, offset: offset) {
                    let decryptedObject = encryption.decryptAES(ciphertext: object.ciphertext, iv: object.iv, tag: object.tag, key: key)
                    return decryptedObject
                }
            }
        }
        return nil
    }
    
    static func getPublicAddressCollection(wallet: HDWallet) -> JSONDictionaryArray {
        var currenciesData: JSONDictionaryArray = []
        for item in AppConstants.supportedCryptoCurrency {
            let assetId = CryptoAssetId(rawValue: item.assetId)
            switch assetId {
            case .BTC:
                let data = getWalletDetails(currency: item, wallet: wallet, coinType: .bitcoin)
                currenciesData.append(data)
            case .ETH:
                let data = getWalletDetails(currency: item, wallet: wallet, coinType: .ethereum)
                currenciesData.append(data)
            case .LTC:
                let data = getWalletDetails(currency: item, wallet: wallet, coinType: .litecoin)
                currenciesData.append(data)
            case .BCH:
                let data = getWalletDetails(currency: item, wallet: wallet, coinType: .bitcoinCash)
                currenciesData.append(data)
            case .ADA:
                let data = getWalletDetails(currency: item, wallet: wallet, coinType: .cardano)
                currenciesData.append(data)
            case .EOS:
                let data = getWalletDetails(currency: item, wallet: wallet, coinType: .eos)
                currenciesData.append(data)
            case .XLM:
                let data = getWalletDetails(currency: item, wallet: wallet, coinType: .stellar)
                currenciesData.append(data)
            case .TRX:
                let data = getWalletDetails(currency: item, wallet: wallet, coinType: .tron)
                currenciesData.append(data)
            case .DOT:
                let data = getWalletDetails(currency: item, wallet: wallet, coinType: .polkadot)
                currenciesData.append(data)
            case .XRP:
                let data = getWalletDetails(currency: item, wallet: wallet, coinType: .xrp)
                currenciesData.append(data)
            case .USDT:
                break
            case .XMR:
                break
            case .none:
                break
            }
        }
        return currenciesData
    }
    
    static func getWalletDetails(currency: SupporedCurrencyModel, wallet: HDWallet, coinType: CoinType) -> JSONDictionary {
        let walletAddress = wallet.getAddressForCoin(coin: coinType)
        var walletData: JSONDictionary = [:]
        walletData[ApiKey.walletAddress] = walletAddress
        walletData[ApiKey.currencyName] = currency.name
        walletData[ApiKey.assetId] = currency.assetId
        return walletData
    }
}

struct CustomAES {

    // MARK: - Value
    // MARK: Private
    private let key: Data
    private let iv: Data


    // MARK: - Initialzier
    init?(key: String) {
        var keyValue = "1234567890123456"
        if key.count == 6 {
            keyValue = key + key + key.dropLast().dropLast()
        } else if key.count == 4 {
            keyValue = key + key + key + key
        }
        guard let keyData = keyValue.data(using: .utf8) else {
            debugPrint("Error: Failed to set a key.")
            return nil
        }

        guard let ivData = keyValue.data(using: .utf8) else {
            debugPrint("Error: Failed to set an initial vector.")
            return nil
        }

        self.key = keyData
        self.iv  = ivData
    }
    
    init?(key: String, iv: String) {
        guard let keyData = key.data(using: .utf8) else {
            debugPrint("Error: Failed to set a key.")
            return nil
        }

        guard let ivData = iv.data(using: .utf8) else {
            debugPrint("Error: Failed to set an initial vector.")
            return nil
        }

        self.key = keyData
        self.iv  = ivData
    }

    // MARK: - Function
    // MARK: Public
    func encrypt(string: String) -> String? {
        let data = crypt(data: string.data(using: .utf8), option: CCOperation(kCCEncrypt))
        return data?.hexString
    }

    func decrypt(data: String) -> String? {
        let data1 = Data(hexString: data)
        guard let decryptedData = crypt(data: data1, option: CCOperation(kCCDecrypt)) else { return nil }
        return String(bytes: decryptedData, encoding: .utf8)
    }

    private func crypt(data: Data?, option: CCOperation) -> Data? {
        guard let data = data else { return nil }

        let cryptLength = data.count + kCCBlockSizeAES128
        var cryptData   = Data(count: cryptLength)

        let keyLength = key.count
        let options   = CCOptions(kCCOptionPKCS7Padding)

        var bytesLength = Int(0)

        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
            data.withUnsafeBytes { dataBytes in
                iv.withUnsafeBytes { ivBytes in
                    key.withUnsafeBytes { keyBytes in
                    CCCrypt(option, CCAlgorithm(kCCAlgorithmAES), options, keyBytes.baseAddress, keyLength, ivBytes.baseAddress, dataBytes.baseAddress, data.count, cryptBytes.baseAddress, cryptLength, &bytesLength)
                    }
                }
            }
        }

        guard UInt32(status) == UInt32(kCCSuccess) else {
            debugPrint("Error: Failed to crypt data. Status \(status)")
            return nil
        }

        cryptData.removeSubrange(bytesLength..<cryptData.count)
        return cryptData
    }
}
