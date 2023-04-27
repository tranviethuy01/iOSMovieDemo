//
//  String.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
enum HMACAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
//    func toCCHmacAlgorithm() -> CCHmacAlgorithm {
//        var result: Int = 0
//        switch self {
//        case .MD5:
//            result = kCCHmacAlgMD5
//        case .SHA1:
//            result = kCCHmacAlgSHA1
//        case .SHA224:
//            result = kCCHmacAlgSHA224
//        case .SHA256:
//            result = kCCHmacAlgSHA256
//        case .SHA384:
//            result = kCCHmacAlgSHA384
//        case .SHA512:
//            result = kCCHmacAlgSHA512
//        }
//        return CCHmacAlgorithm(result)
//    }
//
//    func digestLength() -> Int {
//        var result: CInt = 0
//        switch self {
//        case .MD5:
//            result = CC_MD5_DIGEST_LENGTH
//        case .SHA1:
//            result = CC_SHA1_DIGEST_LENGTH
//        case .SHA224:
//            result = CC_SHA224_DIGEST_LENGTH
//        case .SHA256:
//            result = CC_SHA256_DIGEST_LENGTH
//        case .SHA384:
//            result = CC_SHA384_DIGEST_LENGTH
//        case .SHA512:
//            result = CC_SHA512_DIGEST_LENGTH
//        }
//        return Int(result)
//    }
}
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    /// trimSpaceBeginAndEndString
    ///
    /// - parameter string: String you want to trim
    ///
    /// - returns: Return new string which is trimmed all newline and white space at stand and end
    static func trimSpaceBeginAndEndString(string: String) -> String {
        var newString = string
        
        newString = newString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return newString
    }
    
    
    /// emailIsValid
    ///
    /// - parameter string: String you want to check
    ///
    /// - returns: return true if correct email format, wrong if not
    static func emailIsValid(string: String) -> Bool {
        if string.count > 0 {
            let emailRegEx = "^[a-zA-Z]{1}+[0-9a-zA-Z._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}"
            let emailTest = NSPredicate.init(format: "SELF MATCHES %@", emailRegEx)
            if emailTest.evaluate(with: string) {
                return true
            }
        }
        return false
    }
    
    static func bankAccountIsValid(string: String) -> Bool {
        if string.count > 0 {
            let bankAccountRegEx = "^[0-9a-zA-Z]{1,25}"
            let bankAccountTest = NSPredicate.init(format: "SELF MATCHES %@", bankAccountRegEx)
            if bankAccountTest.evaluate(with: string) {
                return true
            }
        }
        return false
    }
    
    var dateFromISO8601: Date? {
        return DateFormatter.iso8601.date(from: self)
    }
    // formatting text for currency textField
//    func currencyInputFormatting() -> String {
//
//        let int = currencyOutputAsInteger()
//
//
//        // if first number is 0 or all numbers were deleted
//        guard int != 0  else {
//            return ""
//        }
//        return int.createCurrencyManualString(currentStr: "")
//    }
//    func currencyInputFormattingAcceptZero() -> String {
//
//        let int = currencyOutputAsInteger()
//
//
//        // if first number is 0 or all numbers were deleted
//        guard int != 0  else {
//            return "0"
//        }
//        return int.createCurrencyManualString(currentStr: "")
//    }
    
    func currencyOutputAsInteger() -> Int{
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let int = (amountWithPrefix as NSString).integerValue
        return int
    }
    
    func currencyOutputAsDouble() -> Double{
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let doubleValue = (amountWithPrefix as NSString).doubleValue
        return doubleValue
    }
    
    func toDictionary() -> [String: AnyObject]? {
        if let data = data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func convertToQueryFormat() -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        var escaped = ""
        
        //==========================================================================================================
        //
        //  Batching is required for escaping due to an internal bug in iOS 8.1 and 8.2. Encoding more than a few
        //  hundred Chinese characters causes various malloc error crashes. To avoid this issue until iOS 8 is no
        //  longer supported, batching MUST be used for encoding. This introduces roughly a 20% overhead. For more
        //  info, please refer to:
        //
        //      - https://github.com/Alamofire/Alamofire/issues/206
        //
        //==========================================================================================================
        
        escaped = addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? self
        return escaped
    }
    
    func isMatchWithRegex(regexStr: String) -> Bool {
        do {
            let regex = try NSRegularExpression.init(pattern: regexStr, options: [])
            if let result = regex.firstMatch(in: self, options: [], range: NSRange.init(location: 0, length: self.count)) {
                let str = String(self[Range(result.range, in: self)!])
                if str == self {
                    return true
                }
                
            }
            return false
        }
        catch {
            return false
        }
    }
    
    func wordCount() -> Int {
        let componentParts = components(separatedBy: .whitespacesAndNewlines)
        let validParts = componentParts.filter { (part) -> Bool in
            if part.count > 0 {
                return true
            }
            return false
        }
        return validParts.count
    }
    func generateUsername(phoneNumber: String) -> String {
        let unfold = unfoldDiacritic()
        let lowerUnfold = unfold.replacingOccurrences(of: " ", with: "")
        if lowerUnfold.count >= 4 {
            return lowerUnfold.lowercased()
        }
        else {
            return "\(lowerUnfold.lowercased())\(phoneNumber)"
        }
        
    }
    
    func unfoldDiacritic() -> String {
        var unfold = folding(options: [.diacriticInsensitive], locale: Locale.init(identifier: "en_US"))
        let specificCharacter: [String: String] = ["đ": "d",
                                                         "Đ": "D"]
        
        for key in specificCharacter.keys {
            if let character = specificCharacter[key] {
                unfold = unfold.replacingOccurrences(of: key, with: character)
            }
            
        }
        return unfold
    }
    
    func showRealPhoneNumber() -> String {
        if count == 0{
            return self
        }
        
        if hasPrefix("0") {
            return self
        }
        else {
            return "0\(self)"
        }
    }
    
    func checkIfValidatedName() -> Bool {
        if convertToValidName() == self, checkRightNumberOfNameSpacing() == true, checkFirstCharacterIsCapitalized() {
            return true
        }
        return false
    }
    
    func checkRightNumberOfNameSpacing() -> Bool {
        let text = trimmingCharacters(in: .whitespaces)
        let numberOfSeparatedCom = text.components(separatedBy: CharacterSet.whitespaces).count
        let numberOfWhiteSpaces = text.filter { (char) -> Bool in
            if char == " " {
                return true
            }
            return false
        }.count
        if numberOfWhiteSpaces == numberOfSeparatedCom - 1 {
            return true
        }
        return false
    }
    
    func checkFirstCharacterIsCapitalized() -> Bool {
        let separatedComs = components(separatedBy: CharacterSet.whitespaces)
        for separatedCom in separatedComs {
            if separatedCom.count > 0 {
                let firstChar = separatedCom.prefix(1)
                let characterSet = CharacterSet.uppercaseLetters.union(CharacterSet.decimalDigits)
                if let char = firstChar.unicodeScalars.first, characterSet.contains(char) == false {
                    return false
                }
            }
            else {
                return false
            }
            
        }
        
        return true
    }
    func convertToValidName() -> String {
        let validatedCharacterSet = CharacterSet.letters.union(CharacterSet.whitespaces).union(CharacterSet.decimalDigits)
        let filteredStr = components(separatedBy: validatedCharacterSet.inverted).joined()
        return filteredStr
    }
    
    var phoneNumberFormat: String {
        let offSet: Int = 3
        var hasZero: Bool = false
        var trimmedPhoneNumber = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if trimmedPhoneNumber.hasPrefix("0") {
            hasZero = true
            trimmedPhoneNumber.removeFirst()
        }
        let currentJoinedPhoneNumber = trimmedPhoneNumber.split(by: offSet).joined(separator: ".")
        var formattedPhoneNumber: String = hasZero ? "0" : ""
        formattedPhoneNumber += currentJoinedPhoneNumber
        return formattedPhoneNumber
    }
    
    var bankAccountFormat: String {
        var formattedBankNumber = ""
        formattedBankNumber = String(self.enumerated().map { $0 > 0 && $0 % 4 == 0 ? [".", $1] : [$1]}.joined())
        return formattedBankNumber
    }
    
//    func hmac(algorithm: HMACAlgorithm, key: String) -> String {
//        let cKey = key.cString(using: String.Encoding.utf8)
//        let cData = cString(using: String.Encoding.utf8)
//
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: algorithm.digestLength())
//        CCHmac(algorithm.toCCHmacAlgorithm(), cKey!, Int(key.lengthOfBytes(using: .utf8)), cData!, Int(lengthOfBytes(using: .utf8)), result)
//        let digest = stringFromResult(result: result, length: algorithm.digestLength())
//        result.deallocate()
//
//        return digest
//    }
    var base64InputHMAC: String? {
        get {
            if let utf8Str = data(using: .utf8) {
                return utf8Str.base64EncodedString(options: .init(rawValue: 0))
            }
            return nil
        }
    }
    
//    var hashStr: String? {
//        get {
//            if let base64InputHMAC = base64InputHMAC {
//                let hmacSHA256 = base64InputHMAC.hmac(algorithm: .SHA256, key: Constant.kUpdateOrderSecretKey)
//                return "\(base64InputHMAC).\(hmacSHA256)"
//            }
//            return nil
//        }
//
//    }
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }
    
    
    func phoneNumberFormat(with countryCode: String) -> String{
        var formattedCountryCode: String = countryCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if countryCode.hasPrefix("+") {
            formattedCountryCode.removeFirst()
        }
        var formattedPhoneNumber = phoneNumberFormat
        if formattedPhoneNumber.hasPrefix("0") {
            formattedPhoneNumber.removeFirst()
        }
        if formattedCountryCode == "84" || formattedCountryCode == "" {
            return "0" + formattedPhoneNumber
        }
        return "+\(formattedCountryCode)\(formattedPhoneNumber)"
    }
    
    static func value(_ str: String?, withDefault defaultValue: String = "") -> String {
        if let str = str {
            return str.or(defaultValue)
        }
        return defaultValue
    }
    
    func or(_ defaultValue: String) -> String {
        if self.isEmpty {
            return defaultValue
        } else {
            return self
        }
    }
}

extension NSString {
    func convertToValidName() -> NSString {
        let validatedCharacterSet = CharacterSet.letters.union(CharacterSet.whitespaces).union(CharacterSet.alphanumerics)
        let filteredStr = components(separatedBy: validatedCharacterSet.inverted).joined()
        return filteredStr as NSString
    }
}
