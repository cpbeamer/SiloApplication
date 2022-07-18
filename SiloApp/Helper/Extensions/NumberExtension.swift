//
//  NumberExtension.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

extension Double {
    func format(_ decimal: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimal

        let number = NSNumber(value: self)
        if let formattedValue = formatter.string(from: number) {
            return formattedValue
        }
        return "\(self)"
    }
    
    func decimalPlace(_ decimal: Int = 2) -> String {
        return String(format: "%.\(decimal)f", self)
    }
}
