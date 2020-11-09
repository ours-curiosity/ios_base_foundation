// CGColorExtensions.swift - Copyright 2020 SwifterSwift

import UIKit

// MARK: - Properties

public extension CGColor {
    var uiColor: UIColor? {
        return UIColor(cgColor: self)
    }
}

