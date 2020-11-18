//
//  UIFit.swift
//  SwiftyBase
//
//  Created by walker on 2020/10/19.
//

import Foundation

/// 尺寸适配相关
public class UIFit {
    
    /// 屏幕宽度
    public static let width = UIScreen.main.bounds.width
    
    /// 屏幕高度
    public static let height = UIScreen.main.bounds.height
    
    /// 判断设备是不是异形屏
    public class var isHetero : Bool {
        var hetero = false
        if #available(iOS 11.0, *) {
            let safeBottom : CGFloat = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
            hetero = safeBottom > 0.0
        }
        return hetero
    }
    
    /// TableBar距底部区域高度
    public class var tabSafeBottom : CGFloat {
        var bottomHeight : CGFloat = 0.0
        if isHetero {
            bottomHeight = 34.0
        }
        return bottomHeight
    }
    
    /// 状态栏的高度
    public class var statusBarHeight : CGFloat {
        var height = UIApplication.shared.statusBarFrame.size.height
        height = height < 20 ? (tabSafeBottom > 0 ? 44 : 20) : height
        return height
    }
    
    /// 导航栏的高度
    public class var navBarHeight: CGFloat {
        return 44.0
    }
    
    /// 导航栏和状态栏的总高度
    public class var navWithStatusBarHeight : CGFloat {
        let heigth = statusBarHeight + navBarHeight
        return heigth
    }
    
    /// 按宽度适配
    /// - Parameter width: 需要适配的宽度
    /// - Returns: 适配后的宽度
    public class func scaleWidth(_ width: CGFloat) -> CGFloat {
        return (self.width / 375.0) * width
    }
    
    /// 按高度适配
    /// - Parameter height: 需要适配的高度
    /// - Returns: 适配后的高度
    public class func scaleHeight(_ height: CGFloat) -> CGFloat {
        return (self.height / 667.0) * height
    }
    
    /// 适配
    /// - Parameter value: 需要适配的值
    /// - Returns: 适配后的值
    public class func scale(_ value: CGFloat) -> CGFloat {
        return scaleWidth(value)
    }
}

// MARK: - 对常用数字扩展适配属性
public extension CGFloat {
    var scale: CGFloat {
        return UIFit.scale(self)
    }
}

public extension Int {
    var scale: CGFloat {
        return UIFit.scale(CGFloat(self))
    }
}

public extension Double {
    var scale: CGFloat {
        return UIFit.scale(CGFloat(self))
    }
}
