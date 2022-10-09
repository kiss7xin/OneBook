//
//  SubscibeViewController.swift
//  OneBook
//
//  Created by weixin on 2021/6/22.
//

import UIKit
import RxSwift
import SnapKit

class SubscibeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var comicList = [Any]()
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.white
        tw.tableFooterView = UIView()
        tw.delegate = self
        tw.dataSource = self
        tw.register(UComicTCell.self, forCellReuseIdentifier: "UComicTCell")
        return tw
    }()
    
    let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        
        self.view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UComicTCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
