//
//  NSLayoutConstraintExtensions.swift
//  CTBaseFoundation
//
//  Created by walker on 2021/3/28.
//

// 对xib中的约束进行适配

extension NSLayoutConstraint {
    
    /// 是否进行屏幕适配
    @IBInspectable var screenScale: Bool {
        get {
            return true
        }
        set {
            if newValue == true {
                self.constant = UIFit.scale(self.constant)
            }
        }
    }
    
}
