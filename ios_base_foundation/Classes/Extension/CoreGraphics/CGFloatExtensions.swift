// CGFloatExtensions.swift - Copyright 2020 SwifterSwift

import CoreGraphics
import Foundation

// MARK: - Properties

public extension CGFloat {
    /// 绝对值
    var abs: CGFloat {
        return Swift.abs(self)
    }
    /// 向上取整
    var ceil: CGFloat {
        return Foundation.ceil(self)
    }
    /// 向下取整
    var floor: CGFloat {
        return Foundation.floor(self)
    }
    /// 转int
    var int: Int {
        return Int(self)
    }
    /// 转float
    var float: Float {
        return Float(self)
    }
    /// 转double
    var double: Double {
        return Double(self)
    }
}
