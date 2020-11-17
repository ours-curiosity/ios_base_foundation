// UIFontExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit)
import UIKit

// MARK: - Properties

/// 字体类型
public enum FontType: String {
    case regular    = "PingFang-SC-Regular"         // 平方-常规
    case semibold   = "PingFang-SC-Semibold"        // 平方-中黑
    case medium     = "PingFang-SC-Medium"          // 平方-中粗
    case arial      = "Arial-ItalicMT"              // 斜体
    case arialBold  = "Arial-BoldItalicMT"          // 斜体加粗
}

public extension UIFont {
    /// SwifterSwift: Font as bold font
    var bold: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }

    /// SwifterSwift: Font as italic font
    var italic: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0)
    }

    /// SwifterSwift: Font as monospaced font
    ///
    ///     UIFont.preferredFont(forTextStyle: .body).monospaced
    ///
    var monospaced: UIFont {
        let settings = [[
            UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
            UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector
        ]]

        let attributes = [UIFontDescriptor.AttributeName.featureSettings: settings]
        let newDescriptor = fontDescriptor.addingAttributes(attributes)
        return UIFont(descriptor: newDescriptor, size: 0)
    }
}

public extension UIFont {
    
    convenience init(_ type: FontType = .regular, _ fontSize: CGFloat = 17) {
        self.init(name: type.rawValue, size: fontSize)!
    }
}

#endif
