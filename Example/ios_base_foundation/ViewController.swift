//
//  ViewController.swift
//  ios_base_foundation_Example
//
//  Created by walker on 2020/11/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import CTBaseFoundation
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
//        UIImage.imageNamed("", bundleForClass: type(of: self), bundleName: "ios_base")
        
        DebugPrint("a","b","c", canPrint: false)
        
//        testUIFit()
        
        
        self.view.addSubview(self.btn)
        
        self.btn.sizeToFit()
        DebugPrint(self.btn.titleWidth())
    }
    
    func testUIFit() {
        
        print("height: \(UIFit.height), width: \(UIFit.width)")
        print("isHetero: \(UIFit.isHetero)")
        print("navBarSafeHeight: \(UIFit.navBarSafeHeight)")
        print("tabBarSafeBottom: \(UIFit.tabSafeBottom)")
        print("statusBarHeight: \(UIFit.statusBarHeight)")
        print("navBarHeight: \(UIFit.navBarHeight)")
        print("navgationBar all Height: \(UIFit.navWithStatusBarHeight)")
        print(AppDeveice.imsi)
        print(AppDeveice.netType)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        CTPermission.
//        CTPermission.req
//        CTPermission.requestMicPhone(success: {
//            print("----1")
//        }, failed: {
//            print("----2")
//        })
        testUIFit()
    }

    
    lazy var btn: UIButton = {
        let btn = UIButton.init()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        if #available(iOS 13.0, *) {
            btn.setImage(UIImage.init(systemName: "pencil"), for: UIControl.State.normal)
        }
        btn.setTitle("这是个测试啊24adg", for: UIControl.State.normal)
        btn.centerTextAndImage(imageAboveText: true, spacing: 2)
        return btn
    }()
    
}
