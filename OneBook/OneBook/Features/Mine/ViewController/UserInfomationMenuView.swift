//
//  UserInfomationMenuView.swift
//  OneBook
//
//  Created by weixin on 2021/8/4.
//

import UIKit

class TrackInfoModel: NSObject {
    var uid: String = ""
    var name: String = ""
}

protocol TrackProtocol {
    /// 当前页面信息
    func collectionTrackInfo() -> TrackInfoModel
}

class UserInfomationMenuView: UIButton {

    lazy var textLabel = UILabel()/* 内容 */
    lazy var tipsLabel = UILabel()/* 提示 */
    lazy var infoView = UIImageView(image: R.image.medalWallHeaderBack())
    lazy var button = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
        self.creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() {
        textLabel.font = UIFont.systemFont(ofSize: 13)
        tipsLabel.font = UIFont.systemFont(ofSize: 13)
        
        self.addSubview(textLabel)
        self.addSubview(tipsLabel)
        self.addSubview(infoView)
        self.addSubview(button)
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        
        textLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(25)
        }
        
        tipsLabel.snp.makeConstraints { make in
            make.left.equalTo(textLabel)
            make.right.equalToSuperview()
            make.top.equalTo(textLabel.snp.bottom).offset(2)
            make.height.equalTo(17)
            make.bottom.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func buttonClick(sender:UIButton) {
        let find = FindResponds()
        find.findRespondsList(responder: sender, index: 0)
    }
}
