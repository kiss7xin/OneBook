//
//  MineViewController.swift
//  OneBook
//
//  Created by weixin on 2021/6/22.
//

import Foundation
import RxSwift
import RxCocoa

class MineViewController: BaseViewController {
    
    let disposeBag = DisposeBag();
    
    fileprivate lazy var stackView = makeStackView() /* 学分、排名、勋章、证书 */
    fileprivate lazy var creditMenuView = makeStackMenuView(tips: "我的学分")
    fileprivate lazy var rankingMenuView = makeStackMenuView(tips: "我的排名")
    fileprivate lazy var medalMenuView = makeStackMenuView(tips: "我的勋章")
    fileprivate lazy var certificateMenuView = makeStackMenuView(tips: "我的证书")
    
    private lazy var changeButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("切换显示", for: .normal)
        btn.backgroundColor = .gray
        return btn
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(changeButton)
        
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(creditMenuView)
        stackView.addArrangedSubview(rankingMenuView)
        stackView.addArrangedSubview(medalMenuView)
        stackView.addArrangedSubview(certificateMenuView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(60)
        }
        
        creditMenuView.textLabel.text = "9999995分"
        rankingMenuView.textLabel.text = "199名"
        medalMenuView.textLabel.text = "899枚"
        certificateMenuView.textLabel.text = "9328372张"
        
        changeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(stackView.snp.bottom).offset(16)
        }
        
        changeButton.rx.tap.bind{[weak self] in
            let arcNum = arc4random()%4
            for i in 0 ..< (self?.stackView.arrangedSubviews.count)! {
                let hidden = i > arcNum
                let view = self?.stackView.arrangedSubviews[i]
                view!.isHidden = hidden
            }
            
        }.disposed(by:disposeBag)
        
        creditMenuView.rx.tap.asSignal().map { "1"}
    }
    
    private func makeStackView() -> UIStackView {
        let stack = UIStackView.init()
        stack.alignment = .top
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.backgroundColor = .orange
        stack.spacing = 20
        return stack
    }
    
    private func makeStackMenuView(tips:String) -> UserInfomationMenuView {
        let menuView = UserInfomationMenuView()
        menuView.tipsLabel.text = tips;
        return menuView
    }
}
