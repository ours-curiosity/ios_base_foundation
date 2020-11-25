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
        UIImage.imageNamed("", bundleForClass: type(of: self), bundleName: "ios_base")
    }

}
