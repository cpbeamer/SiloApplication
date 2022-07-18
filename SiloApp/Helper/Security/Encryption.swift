//
//  Encryption.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import CommonCrypto
import CryptoKit

class Encryption {
    
    struct EncryptedObject {
        var ciphertext: String
        var iv: String
        var tag: String
    }
    
    //Random iv length
    let ivLength = 16
    
    //pbkdf2 with SHA1 Encryption
    func pbkdf2SHA1(password: String, salt: Data, keyByteCount: Int, rounds: Int) -> Data? {
        return pbkdf2(hash: CCPBKDFAlgorithm(kCCPRFHmacAlgSHA1), password: password, salt: salt, keyByteCount: keyByteCount, rounds: rounds)
    }
    
    //pbkdf2 with SHA256 Encryption
    func pbkdf2SHA256(password: String, salt: Data, keyByteCount: Int, rounds: Int) -> Data? {
        return pbkdf2(hash: CCPBKDFAlgorithm(kCCPRFHmacAlgSHA256), password: password, salt: salt, keyByteCount: keyByteCount, rounds: rounds)
    }
    
    //pbkdf2 with SHA512 Encryption
    func pbkdf2SHA512(password: String, salt: Data, keyByteCount: Int, rounds: Int) -> Data? {
        return pbkdf2(hash: CCPBKDFAlgorithm(kCCPRFHmacAlgSHA512), password: password, salt: salt, keyByteCount: keyByteCount, rounds: rounds)
    }
    
    //pbkdf2 Encryption
    private func pbkdf2(hash: CCPBKDFAlgorithm, password: String, salt: Data, keyByteCount: Int, rounds: Int) -> Data? {
        guard let passwordData = password.data(using: .utf8) else { return nil }
        var derivedKeyData = Data(repeating: 0, count: keyByteCount)
        let derivedCount = derivedKeyData.count
        let derivationStatus: Int32 = derivedKeyData.withUnsafeMutableBytes { derivedKeyBytes in
            let keyBuffer: UnsafeMutablePointer<UInt8> =
                derivedKeyBytes.baseAddress!.assumingMemoryBound(to: UInt8.self)
            return salt.withUnsafeBytes { saltBytes -> Int32 in
                let saltBuffer: UnsafePointer<UInt8> = saltBytes.baseAddress!.assumingMemoryBound(to: UInt8.self)
                return CCKeyDerivationPBKDF(
                    CCPBKDFAlgorithm(kCCPBKDF2),
                    password,
                    passwordData.count,
                    saltBuffer,
                    salt.count,
                    hash,
                    UInt32(rounds),
                    keyBuffer,
                    derivedCount)
            }
        }
        return derivationStatus == kCCSuccess ? derivedKeyData : nil
    }
    
    //SHA1 Hash
    func encryptSHA1(_ string: String) -> String {
        let data = string.data(using: .utf8) ?? Data()
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map({ String(format: "%02hhx", $0) }).joined(separator: "")
    }
    
    //SHA256 Hash
    func encryptSHA256(_ string: String) -> String {
        let data = string.data(using: .utf8) ?? Data()
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map({ String(format: "%02hhx", $0) }).joined(separator: "")
    }
    
    //SHA512 Hash
    func encryptSHA512(_ string: String) -> String {
        let data = string.data(using: .utf8) ?? Data()
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA512($0.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map({ String(format: "%02hhx", $0) }).joined(separator: "")
    }
    
    //Generate random iv
    func generateIV(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    //To create optimised PBKDF2 Key
    func optimisedPBKDF2Key(salt: String, password: String, offset: Int?) -> Data? {
        let keyByteCount = 32
        let rounds = 10000
        if let salt = salt.data(using: .utf8) {
            let shapass = encryptSHA256(password)
            let derivedKey = pbkdf2SHA256(password: shapass, salt: salt, keyByteCount: keyByteCount, rounds: rounds)
            
            //Key Optimisation
            if let offset = offset {
                var reducedHexkey = ""
                if let hexKey = derivedKey?.hexString {
                    debugPrint("PBKDF2 Hexkey:- \(hexKey)")
                    for index in 0..<32 {
                        let character = hexKey[hexKey.index(hexKey.startIndex, offsetBy: index+offset)]
                        reducedHexkey += String(character)
                    }
                    debugPrint("Reduced Hexkey:- \(reducedHexkey)")
                }
                let alteredKey = reducedHexkey.data(using: .utf8)
                debugPrint(alteredKey as Any)
                return alteredKey
            }
            
            return derivedKey
        } else {
            debugPrint("Invalid salt")
        }
        return nil
    }
    
    //AES encryption
    func encryptAES(message: String, key: Data, iv: String) -> EncryptedObject? {
        if let data = message.data(using: .utf8), let iv = Data(base64Encoded: iv) {
            do {
                let key = SymmetricKey(data: key)
                debugPrint("SymmetricKey:- \(key.withUnsafeBytes({Data(Array($0)).base64EncodedString()}))")
                let nonce = try AES.GCM.Nonce(data: iv)
                
                // Encrypt
                let sealedBox = try AES.GCM.seal(data, using: key, nonce: nonce)
                let ciphertext = sealedBox.ciphertext.base64EncodedString()
                let sealedBoxNonce = sealedBox.nonce.withUnsafeBytes{Data(Array($0)).base64EncodedString()}
                let tag = sealedBox.tag.base64EncodedString()
                
                // Logs
                debugPrint("Cipher Text:- \(ciphertext)")
                debugPrint("Nonce:- \(sealedBoxNonce)")
                debugPrint("Tag:- \(tag)")
                
                let object = EncryptedObject(ciphertext: ciphertext, iv: sealedBoxNonce, tag: tag)
                return object
            } catch {
                debugPrint(error.localizedDescription)
            }
        } else {
            debugPrint("Invalid input(s)")
        }
        return nil
    }
    
    //AES decryption
    func decryptAES(ciphertext: String, iv: String, tag: String, key: Data) -> String? {
        if let ciphertext = Data(base64Encoded: ciphertext),
           let iv = Data(base64Encoded: iv), let tag = Data(base64Encoded: tag) {
            do {
                let key = SymmetricKey(data: key)
                debugPrint(key.withUnsafeBytes({ Data(Array($0)).base64EncodedString() }))
                let nonce = try AES.GCM.Nonce(data: iv)
                
                // Decrypt
                let sealedBoxRestored = try AES.GCM.SealedBox(nonce: nonce, ciphertext: ciphertext, tag: tag)
                let decryptedData = try AES.GCM.open(sealedBoxRestored, using: key)
                
                if let decrypted = String(data: decryptedData, encoding: .utf8) {
                    // Logs
                    debugPrint("Decrypted:- \(decrypted)")
                    return decrypted
                } else {
                    debugPrint("Unable to parse decrypted object")
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        } else {
            debugPrint("Invalid input(s)")
        }
        return nil
    }
    
    //Encryption
    func encrypt(message: String, salt: String, password: String, offset: Int? = nil) -> EncryptedObject? {
        if let key = optimisedPBKDF2Key(salt: salt, password: password, offset: offset) {
            let iv = generateIV(length: ivLength)
            let encryptedObject = encryptAES(message: message, key: key, iv: iv)
            return encryptedObject
        }
        return nil
    }
    
    //Decryption
    func decrypt(object: EncryptedObject, salt: String, password: String, offset: Int? = nil) -> String? {
        if let key = optimisedPBKDF2Key(salt: salt, password: password, offset: offset) {
            let decryptedObject = decryptAES(ciphertext: object.ciphertext, iv: object.iv, tag: object.tag, key: key)
            return decryptedObject
        }
        return nil
    }
}
