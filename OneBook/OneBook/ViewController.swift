//
//  ViewController.swift
//  OneBook
//
//  Created by weixin on 2021/5/17.
//

import UIKit
import SwiftTheme

class ViewController: UIViewController {
    
    @objc func changeTheme() {
        MyThemes.switchToNext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}



