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
    
    private var comicList = [
        "你好哒哒哒哒阿里大打了卡大家啊来得及阿卡拉大就较大来得及水岸帝景打,较大来得及水岸帝景打。",
        ""]
    private var footerViewList: [UIView] = []
    
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
        
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .blue
        btn.frame = CGRectMake(20, 500, 100, 100)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    @objc func click() {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return comicList.count
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UComicTCell", for: indexPath)
        cell.userActivity?.title = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        
        let lab = UILabel()
        lab.text = "留言"
        lab.sizeToFit()
        view.addSubview(lab)
        lab.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(12)
        }
        
        let maxWidth = self.view.frame.width - 16 - lab.frame.size.width - 16 - 16
        let footer = InputFooterView()
        footer.maxWidth = maxWidth
        footer.placeHolderText = "请说明"
        view.addSubview(footer)
        footer.snp.makeConstraints { make in
            make.left.equalTo(lab.snp.right).offset(16)
            make.right.equalTo(-16)
            make.top.equalTo(lab)
            make.bottom.equalTo(-12)
        }
        footer.heightChangeBlock = { height in
            tableView.beginUpdates()
            tableView.setNeedsUpdateConstraints()
            tableView.endUpdates()
        }
        footer.newMsgBlock = { string in
            self.comicList[section] = string
        }
        footer.text = self.comicList[section]
        return view
    }
}

