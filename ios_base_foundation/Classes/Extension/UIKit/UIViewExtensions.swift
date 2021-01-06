// UIViewExtensions.swift - Copyright 2020 SwifterSwift
import UIKit
/// 线的位置
public enum LinePosition: Int {
    case top = 0
    case bottom = 1
    case center = 2
}

public extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = color.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var ct_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }
    
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
    
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// SwifterSwift: Masks to bounds of view; also inspectable from Storyboard.
    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    /// SwifterSwift: Get view's parent view controller
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
}

public extension UIView {
    /// SwifterSwift: Recursively find the first responder.
    func firstResponder() -> UIView? {
        var views = [UIView](arrayLiteral: self)
        var index = 0
        repeat {
            let view = views[index]
            if view.isFirstResponder {
                return view
            }
            views.append(contentsOf: view.subviews)
            index += 1
        } while index < views.count
        return nil
    }
    
    /// SwifterSwift: Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    /// SwifterSwift: Add shadow to view.
    ///
    /// - Note: This method only works with non-clear background color, or if the view has a `shadowPath` set.
    /// See parameter `opacity` for detail.
    ///
    /// - Parameters:
    ///   - color: shadow color (default is #137992).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5). It will also be affected by the `alpha` of `backgroundColor`
    func addShadow(
        ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0),
        radius: CGFloat = 3,
        offset: CGSize = .zero,
        opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    /// SwifterSwift: Add array of subviews to view.
    ///
    /// - Parameter subviews: array of subviews to add to self.
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    
    /// SwifterSwift: Load view from nib.
    ///
    /// - Parameters:
    ///   - name: nib name.
    ///   - bundle: bundle of nib (default is nil).
    /// - Returns: optional UIView (if applicable).
    class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    /// SwifterSwift: Load view of a certain type from nib
    ///
    /// - Parameters:
    ///   - withClass: UIView type.
    ///   - bundle: bundle of nib (default is nil).
    /// - Returns: UIView
    class func loadFromNib<T: UIView>(withClass name: T.Type, bundle: Bundle? = nil) -> T {
        let named = String(describing: name)
        guard let view = UINib(nibName: named, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? T else {
            fatalError("First element in xib file \(named) is not of type \(named)")
        }
        return view
    }
    
    /// 从Nib初始化一个View by walker
    /// - Parameter bundle: 初始化时指定的包
    /// - Returns: 指定类型的UIView
    class func loadViewFromNib<T>(bundle: Bundle? = nil) -> T {
        return UINib(nibName: self.className, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! T
    }
    
    /// SwifterSwift: Remove all subviews in view.
    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    /// 添加点击手势
    /// - Parameters:
    ///   - target: 事件响应者
    ///   - action: 事件
    ///   - numberOfTapsRequired: 点击次数
    ///   - numberOfTouchesRequired: 手指个数
    /// - Returns:
    @discardableResult
    func addTapGestureRecognizer(target : Any?, action : Selector?, numberOfTapsRequired: Int = 1, numberOfTouchesRequired: Int = 1) -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer.init(target: target, action: action)
        tapGesture.numberOfTapsRequired    = numberOfTapsRequired;
        tapGesture.numberOfTouchesRequired = numberOfTouchesRequired;
        tapGesture.cancelsTouchesInView    = true;
        tapGesture.delaysTouchesBegan      = true;
        tapGesture.delaysTouchesEnded      = true;
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
        
        return tapGesture
    }
    
    /// - 添加细线，height细线高度
    @discardableResult
    func addLine(position : LinePosition, color : UIColor, height : CGFloat, leftPadding : CGFloat, rightPadding : CGFloat) -> UIView {
        let line = UIView.init()
        line.backgroundColor = color;
        line.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(line)
        line.leftAnchor.constraint(equalTo: leftAnchor, constant: leftPadding).isActive = true
        line.rightAnchor.constraint(equalTo: leftAnchor, constant: rightPadding).isActive = true
        line.heightAnchor.constraint(equalToConstant: height).isActive = true
        switch position {
        case .top:
            line.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        case .bottom:
            line.bottomAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        case .center:
            line.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
            line.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        }
        return line
    }
}

