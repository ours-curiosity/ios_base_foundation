//
//  ViewController.swift
//  ios_base_foundation_Example
//
//  Created by walker on 2020/11/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import iOSBaseFoundation
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }

    @IBAction func ct_showToast(_ sender: UIButton) {
        
//        CTToast.ct_showPositionToast(baseView: nil, message: "这是一个toast", title: nil, image: nil, completion: nil)
    }
    
    
    @IBAction func ct_showIndicator(_ sender: UIButton) {
        // 指示器
//        CTToast.ct_showIndicator(baseView: nil, preventUserAction: true, position: .center)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            CTToast.ct_hideIndicator(baseView: nil)
//        }
    }
}
