// FloatingPointExtensions.swift - Copyright 2020 SwifterSwift

import Foundation

// MARK: - Properties

public extension FloatingPoint {
    /// SwifterSwift: Absolute value of number.
    var abs: Self {
        return Swift.abs(self)
    }

    /// SwifterSwift: Check if number is positive.
    var isPositive: Bool {
        return self > 0
    }

    /// SwifterSwift: Check if number is negative.
    var isNegative: Bool {
        return self < 0
    }

    /// 向上取整
    var ceil: Self {
        return Foundation.ceil(self)
    }
    /// 向下取整
    var floor: Self {
        return Foundation.floor(self)
    }
}
