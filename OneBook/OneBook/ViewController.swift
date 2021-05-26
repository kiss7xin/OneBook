//
//  ViewController.swift
//  OneBook
//
//  Created by weixin on 2021/5/17.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
        
        let testBtn = UIButton.init(type: .custom)
        testBtn.setTitle("测试按钮", for: .normal)
        testBtn.setImage(.init(named: "navsearch_icon_gray"), for: .normal)
        testBtn.centerContentRelativeLocation(.imageLeftTitleRight, spacing: 6)
        self.view.addSubview(testBtn)
        testBtn.sizeToFit()
        
        let bBtn = UIButton.init(type: .custom)
        bBtn.setTitle("测试按钮", for: .normal)
        bBtn.setImage(.init(named: "navsearch_icon_gray"), for: .normal)
        bBtn.centerContentRelativeLocation(.imageRightTitleLeft, spacing: 10)
        self.view.addSubview(bBtn)
        bBtn.sizeToFit()
        
        var rect:CGRect = bBtn.frame
        rect.origin.y = 50
        bBtn.frame = rect
        
        let cBtn = UIButton.init(type: .custom)
        cBtn.setTitle("测试按钮", for: .normal)
        cBtn.setImage(.init(named: "navsearch_icon_gray"), for: .normal)
        cBtn.centerContentRelativeLocation(.imageUpTitleDown, spacing: 10)
        self.view.addSubview(cBtn)
        cBtn.sizeToFit()
        
        rect = cBtn.frame
        rect.origin.y = 100
        cBtn.frame = rect
        
        let dBtn = UIButton.init(type: .custom)
        dBtn.setTitle("测试按钮", for: .normal)
        dBtn.setImage(.init(named: "navsearch_icon_gray"), for: .normal)
        dBtn.centerContentRelativeLocation(.imageDownTitleUp, spacing: 10)
        self.view.addSubview(dBtn)
        dBtn.sizeToFit()
        
        rect = dBtn.frame
        rect.origin.y = 150
        dBtn.frame = rect
        
        let eBtn = UIButton.init(type: .custom)
        eBtn.setTitle("测试按钮", for: .normal)
        eBtn.setImage(.init(named: "navsearch_icon_gray"), for: .normal)
        self.view.addSubview(eBtn)
        eBtn.sizeToFit()
        
        rect = eBtn.frame
        rect.origin.y = 200
        eBtn.frame = rect
        
        print("image:\(eBtn.imageEdgeInsets)")
        print("text:\(eBtn.titleEdgeInsets)")
        print("content:\(eBtn.contentEdgeInsets)")
        
    }


}



