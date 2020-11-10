//
//  CTToast.swift
//  Building6
//
//  Created by walker on 2020/11/3.
//  Copyright © 2020 funlink-tech. All rights reserved.
//

import Foundation
import Toast_Swift

/// toast的位置
@objc public enum CTToastPosition: Int {
    case top
    case center
    case bottom
    
    public func ct_swiftToastPostion() -> ToastPosition {
        switch self {
        case .top:
            return ToastPosition.top
        case .center:
            return ToastPosition.center
        case .bottom:
            return ToastPosition.bottom
        }
    }
}

public class CTToast {
        
    /// 显示指示器
    /// - Parameters:
    ///   - baseView: 父view
    ///   - prevetUserAction 是否阻止用户交互
    ///   - position: 位置
    public class func ct_showIndicator(baseView: UIView?, preventUserAction: Bool = true, position: CTToastPosition = .center) {
        if let view = (baseView ?? self.ct_defaultView()) {
            view.isUserInteractionEnabled = !preventUserAction
            view.makeToastActivity(position.ct_swiftToastPostion())
        }
    }
    
    /// 显示指示器
    /// - Parameters:
    ///   - baseView: 父view
    ///   - prevetUserAction 是否阻止用户交互
    ///   - point: 中心坐标
    public class func ct_showIndicator(baseView: UIView?, preventUserAction: Bool = true ,point: CGPoint = .zero) {
        (baseView ?? Self.ct_defaultView())?.makeToastActivity(point)
        if let view = (baseView ?? self.ct_defaultView()) {
            view.isUserInteractionEnabled = !preventUserAction
            view.makeToastActivity(point)
        }
    }
    
    /// 显示toast，指定位置
    /// - Parameters:
    ///   - baseView: 父view
    ///   - message: 详细信息
    ///   - duration: 展示时长，默认为3s
    ///   - position: 位置
    ///   - title: 标题
    ///   - image: 图片
    ///   - completion: 展示结束
    public class func ct_showPositionToast(baseView: UIView?, message: String?, duration: TimeInterval = 3.0, position: CTToastPosition = .center, title: String?, image: UIImage?, completion: ((Bool) -> Void)?) {
        (baseView ?? self.ct_defaultView())?.makeToast(message, duration: duration, position: position.ct_swiftToastPostion(), title: title, image: image, style: ToastStyle(), completion: completion)
    }
    
    /// 显示toast，指定坐标
    /// - Parameters:
    ///   - baseView: 父view
    ///   - message: 详细信息
    ///   - duration: 展示时长，默认为3s
    ///   - point: 中心坐标
    ///   - title: 标题
    ///   - image: 图片
    ///   - completion: 展示结束
    public class func ct_showPointToast(baseView: UIView?, message: String?, duration: TimeInterval = 3.0, point: CGPoint = .zero, title: String?, image: UIImage?, completion: ((Bool) -> Void)?) {
        (baseView ?? self.ct_defaultView())?.makeToast(message, duration: duration, point: point, title: title, image: image, style: ToastStyle(), completion: completion)
    }
    
    /// 隐藏toast
    /// - Parameters:
    ///   - baseView: 指示器父view
    public class func ct_hideToast(baseView: UIView?) {
        self.ct_hideAll(baseView: baseView, includeActivity: false, clearQueue: true)
    }

    /// 隐藏指示器
    /// - Parameters:
    ///   - baseView: 指示器父view
    ///   - preventUserAction: 是否阻止用户交互，默认为false
    ///   - delay: 延时时间
    public class func ct_hideIndicator(baseView: UIView?, delay: TimeInterval = 0, preventUserAction: Bool = false) {
        if let view = (baseView ?? self.ct_defaultView()) {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                view.isUserInteractionEnabled = !preventUserAction
                view.hideToastActivity()
            }
        }
    }
    
    /// 隐藏所有的toast
    /// - Parameters:
    ///   - baseView: toast的父View
    ///   - delay: 延迟时间
    ///   - includeActivity: 是否将加载指示器也隐藏
    ///   - clearQueue: 是否清楚所有的toast队列
    public class func ct_hideAll(baseView: UIView?, delay: TimeInterval = 0, includeActivity: Bool = true, clearQueue: Bool = true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            (baseView ?? self.ct_defaultView())?.hideAllToasts(includeActivity: includeActivity, clearQueue: clearQueue)
        }
    }
}

extension CTToast {
    
    /// 默认的view
    /// - Returns: 当前的keyWindow
    class func ct_defaultView() -> UIView? {
        return UIApplication.shared.keyWindow
    }
}
