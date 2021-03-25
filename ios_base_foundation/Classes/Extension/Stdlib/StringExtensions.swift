// StringExtensions.swift - Copyright 2020 SwifterSwift

import Foundation
import UIKit
import CoreGraphics

public extension String {
    /// base64 解码
    var base64Decoded: String? {
        let remainder = count % 4
        
        var padding = ""
        if remainder > 0 {
            padding = String(repeating: "=", count: 4 - remainder)
        }
        
        guard let data = Data(base64Encoded: self + padding,
                              options: .ignoreUnknownCharacters) else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
    /// base64 编码
    var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    /// 字符数组
    var charactersArray: [Character] {
        return Array(self)
    }
    
    
    
    /// 是否包含emoji
    ///
    ///		"Hello 😀".containEmoji -> true
    ///
    var isContainEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            return self.containEmoji(scalar)
        }
        return false
    }
    
    
    /// 是否包含表情
    /// - Parameter scalar: unicode 字符
    /// - Returns: 是表情返回true
    func containEmoji(_ scalar: Unicode.Scalar) -> Bool {
        switch Int(scalar.value) {
        case 0x1F600...0x1F64F: return true // Emoticons
        case 0x1F300...0x1F5FF: return true // Misc Symbols and Pictographs
        case 0x1F680...0x1F6FF: return true // Transport and Map
        case 0x1F1E6...0x1F1FF: return true // Regional country flags
        case 0x2600...0x26FF: return true // Misc symbols
        case 0x2700...0x27BF: return true // Dingbats
        case 0xE0020...0xE007F: return true // Tags
        case 0xFE00...0xFE0F: return true // Variation Selectors
        case 0x1F900...0x1F9FF: return true // Supplemental Symbols and Pictographs
        case 127_000...127_600: return true // Various asian characters
        case 65024...65039: return true // Variation selector
        case 9100...9300: return true // Misc items
        case 8400...8447: return true // Combining Diacritical Marks for Symbols
        default: return false
        }
    }
    
    
    /// 是否包含字母
    ///
    ///		"123abc".hasLetters -> true
    ///		"123".hasLetters -> false
    ///
    var isContainLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// 是否包含数字
    ///
    ///		"abcd".hasNumbers -> false
    ///		"123abc".hasNumbers -> true
    ///
    var isContainNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// 是否仅有字母
    ///
    ///		"abc".isAlphabetic -> true
    ///		"123abc".isAlphabetic -> false
    ///
    var isContainAlphabetic: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasLetters && !hasNumbers
    }
    
    /// 是否同时包含数字和字母
    ///
    ///		// useful for passwords
    ///		"123abc".isAlphaNumeric -> true
    ///		"abc".isAlphaNumeric -> false
    ///
    var isContainAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    
    
    /// 是否是有效的电子邮件格式
    ///
    /// - Note: Note that this property does not validate the email address against an email server. It merely attempts to determine whether its format is suitable for an email address.
    ///
    ///		"john@doe.com".isValidEmail -> true
    ///
    var isValidEmail: Bool {
        // http://emailregex.com/
        let regex =
            "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    ///是否是有效的URL
    ///
    ///		"https://google.com".isValidUrl -> true
    ///
    var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /// 是否是一个有效的文件URL
    ///
    ///		"file://Documents/file.txt".isValidFileUrl -> true
    ///
    var isValidFileUrl: Bool {
        return URL(string: self)?.isFileURL ?? false
    }
    
    
    /// 是否只包含数字
    ///
    ///     "123".isDigits -> true
    ///     "1.3".isDigits -> false
    ///     "abc".isDigits -> false
    ///
    var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    
    /// 转int
    var int: Int? {
        return Int(self)
    }
    
    var netUrl: URL? {
        return URL(string: self)
    }
    var localURL:URL?{
        return URL(fileURLWithPath: self, isDirectory: true)
    }
}

// MARK: - Methods

public extension String {
    
    /// 字符串提取
    ///
    ///		"Hello World!"[safe: 3] -> "l"
    ///		"Hello World!"[safe: 20] -> nil
    ///
    /// - Parameter index: index.
    subscript(safe index: Int) -> Character? {
        guard index >= 0, index < count else { return nil }
        return self[self.index(startIndex, offsetBy: index)]
    }
    
    /// 字符串提取  "Hello World!"[safe: 6..<11] -> "World"
    ///
    ///        "Hello World!"[safe: 6..<11] -> "World"
    ///        "Hello World!"[safe: 21..<110] -> nil
    ///
    /// - Parameter range: Range expression.
    subscript<R>(safe range: R) -> String? where R: RangeExpression, R.Bound == Int {
        let range = range.relative(to: Int.min..<Int.max)
        guard range.lowerBound >= 0,
              let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
              let upperIndex = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex) else {
            return nil
        }
        return String(self[lowerIndex..<upperIndex])
    }
    
    /// 复制到剪贴板
    func copyToPasteboard() {
        UIPasteboard.general.string = self
    }
    
    
    /// 转日期
    ///
    ///		"2017-01-15".date(withFormat: "yyyy-MM-dd") -> Date set to Jan 15, 2017
    ///		"not date string".date(withFormat: "yyyy-MM-dd") -> nil
    ///
    /// - Parameter format: date format.
    /// - Returns: Date object from string (if applicable).
    func toDate(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    /// 转 utf8Encoded by walker
    ///
    /// - Returns: 返回字符串转成utf8格式的二进制
    func utf8Encoded() -> Data? {
        return self.data(using: String.Encoding.utf8)
    }
}

// MARK: - 计算个数，判空
/// by walker
public extension String {
    
    /// 是否是空字符串， 空格也会返回true by walker
    ///
    /// - Parameter string: 需要检测的字符串
    /// - Returns: 空返回true
    static func isEmpty(string: Any?) -> Bool {
        var empty = true
        if var newStringVaule = string as? String {
            newStringVaule = newStringVaule.removeHeadAndTailSpaceAndNewlines()
            if newStringVaule.count > 0 {
                empty = false
            }
        }
        return empty
    }
    
    /// 去掉首尾空格和换行符(String) by walker
    ///
    /// - Parameter string: 需要操作的字符串
    /// - Returns: 去掉后的字符串
    func removeHeadAndTailSpaceAndNewlines() -> String {
        let whiteSpaceAndNewlines = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whiteSpaceAndNewlines)
    }
    
    /// 移除表情 by walker
    /// - Returns: 移除表情后的字符
    func removeEmoji() -> String {
        var scalars = self.unicodeScalars
        scalars.removeAll(where: containEmoji(_:))
        return String(scalars)
    }
    
    /// 计算字符个数（英文 = 1，数字 = 1，汉语 = 2）
    /// - Returns: 返回字符的个数
    func countOfChars() -> Int {
        var count = 0
        guard self.count > 0 else { return 0}
        for i in 0...self.count - 1 {
            let c: unichar = (self as NSString).character(at: i)
            if (c >= 0x4E00) {
                count += 2
            }else {
                count += 1
            }
        }
        return count
    }
    
    /// 根据字符个数返回从指定位置向后截取的字符串（英文 = 1，数字 = 1，汉语 = 2）
    /// - Parameter index: 指定截取的位置
    /// - Returns: 截取后的字符串
    func subString(to index: Int) -> String {
        if self.count == 0 { return "" }
        var number = 0
        var strings: [String] = []
        for c in self {
            let subStr: String = "\(c)"
            let num = subStr.countOfChars()
            number += num
            if number <= index {
                strings.append(subStr)
            } else {
                break
            }
        }
        var resultStr: String = ""
        for str in strings {
            resultStr = resultStr + "\(str)"
        }
        return resultStr
    }
    
    /// 换行的行数
    /// - Returns: 换行的行数
    func lineBreakCount() -> Int {
        return self.components(separatedBy: "\n").count
    }
}

// MARK: - Initializers

public extension String {
    /// 初始化 base64
    ///
    ///		String(base64: "SGVsbG8gV29ybGQh") = "Hello World!"
    ///		String(base64: "hello") = nil
    ///
    /// - Parameter base64: base64 string.
    init?(base64: String) {
        guard let decodedData = Data(base64Encoded: base64) else { return nil }
        guard let str = String(data: decodedData, encoding: .utf8) else { return nil }
        self.init(str)
    }
}

// MARK: - String Rect
public extension String {
    
    /// 获得文字占据的区域大小
    /// - Parameter font: 字体大小
    /// - Parameter maxSize: 最大区域
    /// - Returns: 所占尺寸
    func textRect(font: UIFont, maxSize: CGSize) -> CGRect {
        let attributes: [NSAttributedString.Key:Any] = [NSAttributedString.Key.font: font]
        return self.textRect(attributes: attributes, maxSize: maxSize)
    }
    
    /// 获得文字占据的区域大小
    /// - Parameters:
    ///   - attributes: 字体属性
    ///   - maxSize: 最大区域
    /// - Returns: 所占尺寸
    func textRect(attributes: [NSAttributedString.Key: Any], maxSize: CGSize) -> CGRect {
        let nsString: NSString = self as NSString
        let rect = nsString.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect
    }
}
