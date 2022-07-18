//
//  DictionaryExtension.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import UIKit

extension Dictionary {
    func convertDictionaryToString() -> String? {
        do {
            let jsonAddressData =  try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            let jsonaddressString: String = NSString(data: jsonAddressData, encoding: String.Encoding.utf8.rawValue)! as String
            return jsonaddressString
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}
