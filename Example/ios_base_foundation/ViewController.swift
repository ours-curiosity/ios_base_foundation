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

}
