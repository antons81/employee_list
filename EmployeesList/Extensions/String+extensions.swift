//
//  String+Extension.swift
//  WiseHouse
//
//  Created by Anton Stremovskiy on 06.07.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

extension String {
    func stringToDate(with format: String? = nil) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: self) ?? Date()
    }
}

extension String {
    
    var strPassword: String {
        return "7D0qWaL2" + self
    }
    
    func sha256() -> String{
        if let stringData = strPassword.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
}

extension String {
    
    var quotedText: String {
        return "\"\(self)\""
    }
    
    var truncated: String {
        return String(self.prefix(100) + " ...")
    }
}

extension String {
    var isPhoneValid: Bool {
        let regexp = "^\\+(380)\\s?[7569]{1}[0-9]{1}\\s?[0-9]{3}\\s?[0-9]{4}$"
        let predicate = NSPredicate(format: "self matches %@", regexp)
        return predicate.evaluate(with: self)
    }
}

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return ceil(boundingBox.height)
    }
}

extension String {
    var isBackspace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
}

extension String {
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "1":
            return true
        case "false", "0":
            return false
        default:
            return nil
        }
    }
}

extension String {

    func digitsOnly() -> String{
        let stringArray = self.components(separatedBy: CharacterSet.decimalDigits.inverted)
        let newString = stringArray.joined(separator: "")
        return newString
    }
    
    var uah: String {
        return self + " грн."
    }
}

extension String {
    
    var toDouble: Double {
        return Double(self) ?? 0
    }
    
    var toInt64: Int64 {
        return Int64(self) ?? 0
    }
    
    var toDecimal: Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        let number = formatter.number(from: self)
        return number?.doubleValue ?? 0
    }
    
    func isValidDouble(maxDecimalPlaces: Int, separator: String) -> Bool {
        // Use NumberFormatter to check if we can turn the string into a number
        // and to get the locale specific decimal separator.
        let formatter = NumberFormatter()
        let decimalSeparator = separator
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        formatter.allowsFloats = true // Default is true, be explicit anyways
        
        // Check if we can create a valid number. (The formatter creates a NSNumber, but
        // every NSNumber is a valid double, so we're good!)
        if formatter.number(from: self) != nil {
            // Split our string at the decimal separator
            let split = self.components(separatedBy: decimalSeparator)
            
            // Depending on whether there was a decimalSeparator we may have one
            // or two parts now. If it is two then the second part is the one after
            // the separator, aka the digits we care about.
            // If there was no separator then the user hasn't entered a decimal
            // number yet and we treat the string as empty, succeeding the check
            let digits = split.count == 2 ? split.last ?? "" : ""
            
            // Finally check if we're <= the allowed digits
            return digits.count <= maxDecimalPlaces
        }
        
        return false // couldn't turn string into a valid number
    }
}

extension String {
    var htmlTrimmed: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "",
                                         options: String.CompareOptions.regularExpression,
                                         range: nil)
    }
    
    
    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }
}

extension String {
    
    
    var colorFromHex: UIColor {
        
        var colorString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()

        
        let alpha: CGFloat = 1.0
        let red: CGFloat = self.colorComponentFrom(colorString: colorString, start: 0, length: 2)
        let green: CGFloat = self.colorComponentFrom(colorString: colorString, start: 2, length: 2)
        let blue: CGFloat = self.colorComponentFrom(colorString: colorString, start: 4, length: 2)

        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    private func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {

        let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
        let endIndex = colorString.index(startIndex, offsetBy: length)
        let subString = colorString[startIndex..<endIndex]
        let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
        var hexComponent: UInt64 = 0

        guard Scanner(string: String(fullHexString)).scanHexInt64(&hexComponent) else {
            return 0
        }
        let hexFloat: CGFloat = CGFloat(hexComponent)
        let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
        return floatValue
    }
}
