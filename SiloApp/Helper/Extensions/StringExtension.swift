//
//  StringExtension.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation
import UIKit

extension String {
    
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }
    
    ///Removes all spaces from the string
    var removeSpaces:String {
        return self.replacingOccurrences(of: " ", with: "")
    }

    ///Removes all HTML Tags from the string
    var removeHTMLTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    ///Returns a localized string
    public var localized:String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    ///Removes leading and trailing white spaces from the string
    var byRemovingLeadingTrailingWhiteSpaces:String {
        
        let spaceSet = CharacterSet.whitespaces
        return self.trimmingCharacters(in: spaceSet)
    }
    
    public func trimTrailingWhitespace() -> String {
        if let trailingWs = self.range(of: "\\s+$", options: .regularExpression) {
            return self.replacingCharacters(in: trailingWs, with: "")
        } else {
            return self
        }
    }
    ///Returns 'true' if the string is any (file, directory or remote etc) url otherwise returns 'false'
    var isAnyUrl:Bool{
        return (URL(string:self) != nil)
    }
    
    ///Returns the json object if the string can be converted into it, otherwise returns 'nil'
    var jsonObject:Any? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        return nil
    }
    
    ///Returns the base64Encoded string
    var base64Encoded:String {
        
        return Data(self.utf8).base64EncodedString()
    }
    
    ///Returns the string decoded from base64Encoded string
    var base64Decoded:String? {
        
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }

    func heightOfText(_ width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func widthOfText(_ height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }

    func localizedString(lang:String) ->String {
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        debugPrint(path as Any)
        let bundle = Bundle(path: path!)
        debugPrint(bundle as Any)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    ///Returns 'true' if string contains the substring, otherwise returns 'false'
    func contains(s: String) -> Bool
    {
        return self.range(of: s) != nil ? true : false
    }
    
    ///Replaces occurances of a string with the given another string
    func replace(string: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: string, with: withString, options: String.CompareOptions.literal, range: nil)
    }
    
    ///Converts the string into 'Date' if possible, based on the given date format and timezone. otherwise returns nil
    func toDate(dateFormat:String,timeZone:TimeZone = TimeZone.current)->Date?{
        
        let frmtr = DateFormatter()
        frmtr.locale = Locale(identifier: "en_US_POSIX")
        frmtr.dateFormat = dateFormat
        frmtr.timeZone = timeZone
        return frmtr.date(from: self)
    }
    
    func inDate(format: Date.DateFormat) -> Date {
        if self.isBlank {
            return Date()
        }
        let formatter  = DateFormatter()
        formatter.dateFormat = format.rawValue
        
        if let date = Double(self) {
            return Date(timeIntervalSince1970: TimeInterval(date/1000.0))
        }
        return Date()
        
    }
    
    func dateFromString(dateFormat: String) -> Date? {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        let date = dfmatter.date(from: self)
        return date
    }
    
    func stringToDate(dateFormat:String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: dateFormat) else {
            fatalError()
        }
        debugPrint(date) //Convert String to Date
        return date
    }

    func toDateText(inputDateFormat: String, outputDateFormat: String, timeZone: TimeZone = TimeZone.current) -> String{
        
        if let date = self.toDate(dateFormat: inputDateFormat, timeZone: timeZone) {
            return date.toString(dateFormat: outputDateFormat, timeZone: timeZone)
        } else {
            return ""
        }
    }
    
    ///Capitalize the very first letter of the sentence.
    var SentenceCased: String {
        guard !isEmpty else { return self }
        var result = self
        let substr1 = String(self[startIndex]).uppercased()
        result.replaceSubrange(...startIndex, with: substr1)
        return result
    }

    func checkIfValid(_ validityExression : ValidityExression) -> Bool {
        
        let regEx = validityExression.rawValue
        
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        return test.evaluate(with: self)
    }
    
    func checkIfInvalid(_ validityExression : ValidityExression) -> Bool {
        if validityExression == .email {
            return !(self.checkIfValid(.email) || self.checkIfValid(.emailDoubleDot))
        } else {
            return !self.checkIfValid(validityExression)
        }
    }
    
    ///Capitalize the very first letter of the sentence.
    var capitalizedFirst: String {
        guard !isEmpty else { return self }
        var result = self
        let substr1 = String(self[startIndex]).uppercased()
        result.replaceSubrange(...startIndex, with: substr1)
        return result
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}

enum ValidityExression : String {
    
    case userName = "^(?=.*[a-zA-Z])[A-Z0-9a-z!@$%*#?&_\\^\\+\\.\\=\\-]{2,25}"
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,}"
    case emailDoubleDot = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{2,}"
    case mobileNumber = "^[0-9]{8,12}"
    case password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[A-Z0-9a-z!@$%*#?&_\\^\\+\\.\\=\\-]{8,35}$"
    case name = "^[a-zA-Z]+[a-zA-Z ]{2,34}"
    case fullName = "^(?=.*[a-zA-Z]{1,}+[ ]+[a-zA-Z ]{1,})[a-zA-Z][a-zA-Z ]{2,34}"
    case webUrl = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
}

extension String {

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    var iconFromCurrencyCode: UIImage? {
        return UIImage(named: self.lowercased())
    }
    
    var currencyColor: UIColor? {
        return UIColor(named: self.uppercased())
    }
    
    var currencyCode: String {
        switch self {
        case "USD", "AUD", "CAD":
            return "$"
        case "GBP":
            return "£"
        case "EUR":
            return "€"
        case "CNY":
            return "¥"
        default:
            return "$"
        }
    }
    
    var currencyNameFromCode: String? {
        switch self {
        case "BTC":
            return "Bitcoin"
        case "ETH":
            return "Ethereum"
        case "USDT":
            return "Tether"
        case "XRP":
            return "Ripple"
        case "LTC":
            return "Litecoin"
        case "BCH":
            return "Bitcoin Cash"
        case "ADA":
            return "Cardano"
        case "EOS":
            return "EOS"
        case "XMR":
            return "Monero"
        case "XLM":
            return "Stellar"
        case "TRX":
            return "Tron"
        case "DOT":
            return "Polkadot"
        default:
            return nil
        }
    }
    
    func formatPhoneNumber(with mask: String) -> String {
        if self.count > mask.count {
            return self
        } else {
            let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            var result = ""
            var index = numbers.startIndex // numbers iterator
            // iterate over the mask characters until the iterator of numbers ends
            for ch in mask where index < numbers.endIndex {
                if ch == "X" {
                    // mask requires a number in this place, so take the next one
                    result.append(numbers[index])
                    // move numbers iterator to the next index
                    index = numbers.index(after: index)
                } else {
                    result.append(ch) // just append a mask character
                }
            }
            return result
        }
    }

    var removePhoneNumberMask: String {
        return self.replacingOccurrences(of: "[() -]", with: "", options: .regularExpression)
    }
}

extension NSMutableAttributedString{
    func setColorForText(_ textToFind: String, with color: UIColor?) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if let color = color, range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
}
