//
//  ViewController.swift
//  BaseKit
//
//  Created by tliens on 11/09/2020.
//  Copyright (c) 2020 tliens. All rights reserved.
//

import UIKit
import BaseKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addLine(position: .bottom, color: .hex("#666666"), ply: 1, leftPadding: 0, rightPadding: 0)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

