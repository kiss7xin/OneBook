//
//  BookshelfViewController.swift
//  OneBook
//
//  Created by weixin on 2021/6/18.
//
import UIKit
import SnapKit

class BookshelfViewController: BaseViewController {
    override func viewDidLoad() {
        
        testTruncatingRemainder()
        
        self.view.backgroundColor = .white
        
        let image = R.image.shadow()!.resizableImage(withCapInsets: UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24), resizingMode: .stretch)
        let view = UIImageView(image: image)
        self.view.addSubview(view)
        view.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.height.equalTo(200)
        }
        
        //        初始化一个基于模糊效果的视觉效果视图
        let blackView = UIView()
        blackView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
        
        let blur = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.bounds = blackView.bounds
        
//        blurView.layer.cornerRadius = 30
//        blurView.layer.masksToBounds = true
        self.view.addSubview(blackView)
        blackView.addSubview(blurView)
        blackView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(400)
            $0.height.equalTo(200)
        }
        
        
        let jsonString = "{\"doubleOptional\":1.1,\"stringImplicitlyUnwrapped\":\"hello\",\"int\":1}"
        let jsondata = jsonString.data(using: .utf8)
        
        do {
            let ok = try JSONSerialization.jsonObject(with: jsondata!, options: .mutableContainers) as AnyObject
            print("ok:\(ok)")
        } catch {
            print(error)
        }
        
        
        let titleLabel = UILabel.init()
        titleLabel.numberOfLines = 2
        titleLabel.text = "这是一条数据,这是一条数据,这是一条数据,这是一条数据,这是一条数据,这是一条数据"
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-200)
            $0.top.equalToSuperview().offset(68)
        }
        
        let t2 = UILabel.init()
        t2.numberOfLines = 2
        t2.text = "这是一条数据"
        self.view.addSubview(t2)
        
        t2.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-200)
            $0.top.equalTo(titleLabel.snp.bottom).offset(68)
        }
        
        let btn = UIButton.init(type: .system)
        btn.setTitle("换主题", for: .normal)
        btn.setImage(R.image.study_center_task_arrow(), for: .normal)
        btn.theme_tintColor = GlobalPicker.accentColor
//        btn.theme_setTitleColor(GlobalPicker.accentColor, forState: .normal)
        self.view.addSubview(btn)
        btn.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.top.equalTo(t2.snp.bottom).offset(16)
        }
        btn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        buttonCorner()
        
        
        
        let inputView = CodeInputView()
        inputView.backgroundColor = .orange
        self.view.addSubview(inputView)
        inputView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(btn.snp.bottom).offset(20)
            make.height.equalTo(80)
        }
        
        let codebtn = UIButton.init(type: .system)
        codebtn.setTitle("换主题", for: .normal)
        codebtn.setImage(R.image.study_center_task_arrow(), for: .normal)
        codebtn.theme_tintColor = GlobalPicker.accentColor
//        btn.theme_setTitleColor(GlobalPicker.accentColor, forState: .normal)
        self.view.addSubview(codebtn)
        codebtn.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.top.equalTo(inputView.snp.bottom).offset(16)
        }
        codebtn.addTarget(self, action: #selector(codeClick), for: .touchUpInside)
        
        Task {
            await testContinuation()
        }
    }
    
    @objc func buttonClick() {
        MyThemes.switchToNext()
    }
    
    @objc func codeClick() {
        UIPasteboard.general.string = "MS2EWQY72YBKPDFV"
    }
    
    func test() {
        
        //创建一个模型对象并对其进行归档和恢复归档操作
        //初始化刚定义的对象模型
        let user1 = THAccountInfoModel.init()
        
        //设置对象名称和密码属性值
        user1.emailToken = "Jerry"
        
        print(NSHomeDirectory())
        
        //添加异常捕捉语句，用来执行归档和恢复归档操作
        do {
            //创建一个可变二进制数据对象，用来存储归档后的模型对象。归档指的是将Swift对象存储为一个文件或网络上的一个数据块
            let data = try NSKeyedArchiver.archivedData(withRootObject: user1, requiringSecureCoding: true)
            
            let savePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask, true).first

            let savePathUrl = URL(fileURLWithPath: savePath!)

            try? FileManager.default.createDirectory(at: savePathUrl, withIntermediateDirectories: true, attributes: nil)
            let url = savePathUrl.appendingPathComponent("user1.archive")
            try data.write(to: url)
            print("写入文件成功")
            
            
//            //将归档的数据存储在程序包的Preference目录
//            UserDefaults.standard.set(data, forKey: "user1")
//            UserDefaults.standard.synchronize()
//
//            //对归档数据进行加载和恢复归档操作
//            //读取刚刚保存的数据
//            let dataFrom = UserDefaults.standard.data(forKey: "user1")!
            let dataFrom = try Data.init(contentsOf: url,options: .alwaysMapped)
            
            //恢复归档操作,恢复成内存中一个Swift对象
            let savedUser = try NSKeyedUnarchiver.unarchivedObject(ofClass: THAccountInfoModel.self, from: dataFrom)
            print(savedUser?.emailToken ?? "")
        }
        catch {
            print("Archive error.")
        }
        
        do {
            let path = Bundle.main.path(forResource: "user1", ofType: "archive")
            let url = URL.init(fileURLWithPath: path!)
            let dataFrom = try Data.init(contentsOf: url,options: .alwaysMapped)
            let savedUser = try NSKeyedUnarchiver.unarchivedObject(ofClass: THAccountInfoModel.self, from: dataFrom)
            guard let user = savedUser else {
                fatalError("THAccountInfoModel - can't get THAccountInfoModel")
            }
            print(user.emailToken!)
        } catch {
            print("THAccountInfoModel - can't encode data")
        }
        
        
    }
    
    func buttonCorner() {
        let button = UIButton(type:.custom)
        button.frame = CGRect(x: 50, y: 100, width: 200, height: 18)
        button.setTitle("圆角设置", for: .normal)
        button.backgroundColor = UIColor.orange
               
        button.layer.mask = self.configRectCorner(view: button, corner: [.topLeft, .bottomRight], radii: CGSize(width: 18, height: 18))
        view.addSubview(button)
    }
    
    /// 圆角设置
    ///
    /// - Parameters:
    ///   - view: 需要设置的控件
    ///   - corner: 哪些圆角
    ///   - radii: 圆角半径
    /// - Returns: layer图层
    func configRectCorner(view: UIView, corner: UIRectCorner, radii: CGSize) -> CALayer {
        
        let maskPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: corner, cornerRadii: radii)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        
        return maskLayer
    }
    
    func testTruncatingRemainder() {
        let val = 9 * 3600 + 38 * 60 + 6
        let hour = val / 3600
        let minute = (val - hour * 3600)/60
        let second = val - hour * 3600 - minute * 60
        let result = String(format:"%02d小时%02d分钟%02d秒",hour,minute,second)
        print(result)
        
        let finishCount = 0.0
        let totalCount = 100.0
        let progress = CGFloat(CGFloat(finishCount)/CGFloat(totalCount)) * 100.0
        let percent = String(format: "%.0f", progress)
        print("percent:\(percent)")
    }
    
    func testContinuation() async {
        let con = Continuation()
        do { 
            try await con.main()
        } catch {
            
        }
    }
}
