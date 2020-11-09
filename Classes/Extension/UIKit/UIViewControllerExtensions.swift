// UIViewControllerExtensions.swift - Copyright 2020 SwifterSwift

import UIKit

// MARK: - Properties

public extension UIViewController {
    /// SwifterSwift: Check if ViewController is onscreen and not hidden.
    var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return isViewLoaded && view.window != nil
    }
}

// MARK: - Methods

public extension UIViewController {
    /// SwifterSwift: Instantiate UIViewController from storyboard
    ///
    /// - Parameters:
    ///   - storyboard: Name of the storyboard where the UIViewController is located
    ///   - bundle: Bundle in which storyboard is located
    ///   - identifier: UIViewController's storyboard identifier
    /// - Returns: Custom UIViewController instantiated from storyboard
    class func instantiate(from storyboard: String = "Main", bundle: Bundle? = nil, identifier: String? = nil) -> Self {
        let viewControllerIdentifier = identifier ?? String(describing: self)
        let storyboard = UIStoryboard(name: storyboard, bundle: bundle)
        guard let viewController = storyboard
                .instantiateViewController(withIdentifier: viewControllerIdentifier) as? Self else {
            preconditionFailure(
                "Unable to instantiate view controller with identifier \(viewControllerIdentifier) as type \(type(of: self))")
        }
        return viewController
    }
    
    /// SwifterSwift: Assign as listener to notification.
    ///
    /// - Parameters:
    ///   - name: notification name.
    ///   - selector: selector to run with notified.
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    /// SwifterSwift: Unassign as listener to notification.
    ///
    /// - Parameter name: notification name.
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    /// SwifterSwift: Unassign as listener from all notifications.
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// SwifterSwift: Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - buttonTitles: (Optional)list of button titles for the alert. Default button i.e "OK" will be shown if this paramter is nil
    ///   - highlightedButtonIndex: (Optional) index of the button from buttonTitles that should be highlighted. If this parameter is nil no button will be highlighted
    ///   - completion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an argument
    /// - Returns: UIAlertController object (discardable).
    @discardableResult
    func showAlert(
        title: String?,
        message: String?,
        buttonTitles: [String]? = nil,
        highlightedButtonIndex: Int? = nil,
        completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    /// SwifterSwift: Helper method to add a UIViewController as a childViewController.
    ///
    /// - Parameters:
    ///   - child: the view controller to add as a child
    ///   - containerView: the containerView for the child viewcontroller's root view.
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        self.addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// SwifterSwift: Helper method to remove a UIViewController from its parent.
    func removeViewAndControllerFromParentViewController() {
        guard parent != nil else { return }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    /// SwifterSwift: Helper method to present a UIViewController as a popover.
    ///
    /// - Parameters:
    ///   - popoverContent: the view controller to add as a popover.
    ///   - sourcePoint: the point in which to anchor the popover.
    ///   - size: the size of the popover. Default uses the popover preferredContentSize.
    ///   - delegate: the popover's presentationController delegate. Default is nil.
    ///   - animated: Pass true to animate the presentation; otherwise, pass false.
    ///   - completion: The block to execute after the presentation finishes. Default is nil.
    func presentPopover(
        _ popoverContent: UIViewController,
        sourcePoint: CGPoint,
        size: CGSize? = nil,
        delegate: UIPopoverPresentationControllerDelegate? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil) {
        popoverContent.modalPresentationStyle = .popover
        
        if let size = size {
            popoverContent.preferredContentSize = size
        }
        
        if let popoverPresentationVC = popoverContent.popoverPresentationController {
            popoverPresentationVC.sourceView = view
            popoverPresentationVC.sourceRect = CGRect(origin: sourcePoint, size: .zero)
            popoverPresentationVC.delegate = delegate
        }
        
        present(popoverContent, animated: animated, completion: completion)
    }
    
    /// 获得当前的顶层控制器 by walker
    /// - Returns: 顶层控制器
    class func getTopViewController() -> UIViewController? {
        
        var window = UIApplication.shared.keyWindow
        //是否为当前显示的window
        if window?.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window?.rootViewController
        return getTopViewController(vc)
    }
    
    /// 获得指定控制器的顶层控制器 by walker
    /// - Parameter viewController: 指定的控制器
    /// - Returns: 指定控制器的顶层控制器
    class func getTopViewController(_ viewController: UIViewController?) -> UIViewController? {
        
        guard let currentVC = viewController else {
            return nil
        }
        
        if let nav = currentVC as? UINavigationController {
            // 控制器是nav
            return getTopViewController(nav.visibleViewController)
        } else if let tabC = currentVC as? UITabBarController {
            // tabBar 的跟控制器
            return getTopViewController(tabC.selectedViewController)
        } else if let presentVC = currentVC.presentedViewController {
            //modal出来的 控制器
            return getTopViewController(presentVC)
        } else {
            // 返回顶控制器
            return currentVC
        }
    }
    
    /// 获得当前的顶层控制器 by walker
    class var topViewController: UIViewController? {
        return self.getTopViewController()
    }
    
    /// 是否是被模态出的控制器 by walker
    var isPushed: Bool {
        if self.navigationController == nil {
            return false
        }
        
        let VCs = self.navigationController?.viewControllers
        if VCs != nil && VCs!.count >= 1 {
            if VCs?.last == self && VCs?.first != self {
                return true
            }
        }
        return false
    }
    
    /// 找到当前控制器的 navigationbar by walker
    var currentNavigationBar: UINavigationBar? {
        
        var bar : UINavigationBar?
        
        if self.isKind(of: UINavigationController.self) {
            let navController = self as! UINavigationController
            bar = navController.navigationBar
        } else {
            bar = self.navigationController?.navigationBar
        }
        
        return bar
    }

    /// 设置导航栏颜色 by walker
    /// - Parameter color: 颜色
    func setTitleColor(_ color: UIColor?) {
        guard let newColor = color else { return }
        
        var attributes = self.currentNavigationBar?.titleTextAttributes
        if attributes == nil && color != nil {
            attributes = [NSAttributedString.Key.foregroundColor : newColor]
        } else {
            attributes![NSAttributedString.Key.foregroundColor] = newColor
        }
        self.currentNavigationBar?.titleTextAttributes = attributes
    }
    
    /// 设置导航栏字体 by walker
    /// - Parameter font: 字体
    func setTitleFont(_ font: UIFont?) {
        guard let newFont = font else { return }
        
        var attributes = self.currentNavigationBar?.titleTextAttributes
        if attributes == nil {
            attributes = [NSAttributedString.Key.font : newFont]
        } else {
            attributes![NSAttributedString.Key.font] = newFont
        }
        self.currentNavigationBar?.titleTextAttributes = attributes
    }
    
}
