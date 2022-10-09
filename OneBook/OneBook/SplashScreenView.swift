//
//  SplashScreenView.swift
//  EnterpriseUniversity
//
//  Created by weixin on 2021/8/26.
//

import UIKit

public enum SplashScreenType: Int {
    case localImage
    case netImage
}

public let ToAdVC = "toAdVC"

class SplashScreenView: UIView {
    open var showTime:Int = 5 //跳过按钮显示时间 为0时 不显示读秒手动跳过，默认5秒倒计时
    open var img:String? // 图片
    open var linkUrl:String? // 跳转链接
    
    fileprivate var adImageView: UIImageView = {
        let adImageView = UIImageView.init(frame: UIScreen.main.bounds)
        adImageView.isUserInteractionEnabled = true
        adImageView.contentMode = .scaleAspectFill
        adImageView.clipsToBounds = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(SplashScreenView.toAdVC))
        adImageView.addGestureRecognizer(tap)
        return adImageView
    }()
    
    fileprivate var countButton:UIButton = {
        let countButton = UIButton(type: .custom)
        countButton.frame = CGRect(x: UIScreen.main.bounds.size.width - 84, y: 30, width: 60, height: 30)
        countButton.addTarget(self, action: #selector(SplashScreenView.dismiss), for: .touchUpInside)
        countButton.backgroundColor = .gray
        countButton.layer.cornerRadius = 4
        return countButton
    }()
    
    fileprivate lazy var countTimer:Timer?  = {
        let countTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SplashScreenView.countDown), userInfo: nil, repeats: true)
        return countTimer
    }()
    
    fileprivate var count:Int = 0
    
    fileprivate var type:SplashScreenType?
    
    public init(type:SplashScreenType) {
        super.init(frame: UIScreen.main.bounds)
        self.type = type
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        self.addSubview(adImageView)
        self.addSubview(countButton)
        
        adImageView.frame = self.bounds
    }
    
    @objc func dismiss() {
        if countTimer != nil {
            countTimer?.invalidate()
            countTimer = nil
        }
        
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0.0
        } completion: { (finished) in
            self.removeFromSuperview()
//            self.adWindow = nil
        }
    }
    
    @objc func toAdVC() {
        self.dismiss()
        NotificationCenter.default.post(name: NSNotification.Name.init(ToAdVC), object: linkUrl, userInfo: nil)
    }
    
    @objc func countDown() {
        count = count - 1
        countButton.setTitle("跳过\(count)", for: .normal)
        if count == 0{
            self.dismiss()
        }
    }
    
    func show(showTime: Int) {
        
        guard let image = self.img else { return }
    
        print("image:"+image)
        if type  == .netImage {
            self.adImageView.image = UIImage.init(contentsOfFile:image)
        } else {
            self.adImageView.image = UIImage.init(named:image)
        }
        
        // 倒计时开启
        if showTime != 0 {
            self.showTime = showTime
            countButton.setTitle("跳过\(showTime)", for: .normal)
            startTimer()
        } else {
            countButton.setTitle("跳过\(showTime)", for: .normal)
        }
        
        self.backgroundColor = .orange
        self.frame = UIScreen.main.bounds
        let window = UIApplication.shared.delegate?.window
        window??.isHidden = false
        window??.addSubview(self)
        
//        let window = UIWindow.init(frame: UIScreen.main.bounds)
//        window.windowLevel = UIWindow.Level.alert
//        window.isHidden = false
//        window.alpha = 0
//        UIView.animate(withDuration: 0.3) {
//            window.alpha = 1
//        }
//        window.addSubview(self)
//        self.adWindow = window
    }
    
    fileprivate func startTimer(){
        count = showTime
        RunLoop.main.add(self.countTimer!, forMode: RunLoop.Mode.common)
    }
}
