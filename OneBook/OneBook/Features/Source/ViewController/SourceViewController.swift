//
//  SourceViewController.swift
//  OneBook
//
//  Created by weixin on 2021/6/22.
//

import UIKit
import Kingfisher

enum StatisticEventCode: String {
    case none
    case my = "我的"
    case my_info = "我的个人信息"
    case my_score = "我的学分"
    case my_rank = "我的排名"
    case my_study_board = "我的学习看板"
    case my_study_data = "我的学习数据"
}

class SourceViewController: BaseViewController {
    override func viewDidLoad() {
        
    }
}

class OldSourceViewController: BaseViewController {
    
    private var eventCode:StatisticEventCode?
    
    override func viewDidLoad() {
        
        print(StatisticEventCode.none.rawValue)
        print(StatisticEventCode.my.rawValue)
        
        
        let str = "1-2-3-4"
        let str1 = str.suffix(3)
        print(str1)
        
        let key = "1-"
        let range = str.range(of: key)!
        var str2 = str
        str2.removeSubrange(range)
        print(str2)
        
        var list = ["1","2","3"]
        list.removeLast()
        print(list)
        
        pushVC(color: .purple)
        presentVC(color: .orange)
        presentVC(color: .white)
        
        let imageView = UIImageView()
        imageView.ci.setImage(url: URL.init(string: "http://www.baidu")!, placeHolder: nil)
        presentVC(color: .gray)
        
        let url = URL(string: "https://example.com/high_resolution_image.png")
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        self.testTipLabel()
    }
    
    func presentVC(color: UIColor) {
        let vc = BaseViewController()
        vc.view.backgroundColor = color
        self.present(vc, animated: true, completion: nil)
    }
    
    func pushVC(color: UIColor) {
        let vc = BaseViewController()
        vc.view.backgroundColor = color
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func testTipLabel() {
        let layerView = UIView()
        layerView.frame = CGRect(x: 70, y: 170, width: 123, height: 18)
        layerView.layer.cornerRadius = 16
        layerView.alpha = 1
        // fillCode
        let bglayer1 = CAGradientLayer()
        bglayer1.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 1.00).cgColor, UIColor(red: 0.99, green: 0.75, blue: 0.49, alpha: 1.00).cgColor]
        bglayer1.locations = [0, 1]
        bglayer1.frame = layerView.bounds
        layerView.layer.addSublayer(bglayer1)
        bglayer1.startPoint = CGPoint(x: -0.19, y: 0.00)
        bglayer1.endPoint = CGPoint(x: 1.00, y: 0.39)
        view.addSubview(layerView)
    }
}

