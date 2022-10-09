//
//  OBTabbarController.swift
//  OneBook
//
//  Created by weixin on 2021/6/18.
//

import Foundation
import UIKit

class OBTabbarController: UITabBarController {
    open override func viewDidLoad() {
        tabBar.isTranslucent = false
        
        let bookVC = BookshelfViewController()
//        addChildViewController(bookVC, title:"", image: .init(named: "ic_bottom_books_e"), selectImage: .init(named: "ic_bottom_books_s"))
        addChildViewController(bookVC, title:"", image: R.image.ic_bottom_books_e(), selectImage: R.image.ic_bottom_books_s())
        
        let sourceVC = SourceViewController()
        addChildViewController(sourceVC, title:"", image: .init(named: "ic_bottom_explore_e"), selectImage: .init(named: "ic_bottom_explore_s"))
        
        let subscribeVC = SubscibeViewController()
        addChildViewController(subscribeVC, title:"", image: .init(named: "ic_bottom_rss_feed_e"), selectImage: .init(named: "ic_bottom_rss_feed_s"))
        
        let mineVC = MineViewController()
        addChildViewController(mineVC, title:"", image: .init(named: "ic_bottom_person_e"), selectImage: .init(named: "ic_bottom_person_s"))
        
        self.tabBar.theme_tintColor = GlobalPicker.accentColor
        self.tabBar.theme_barTintColor = GlobalPicker.bottomBackground
    }
    
    func addChildViewController(_ childViewController: UIViewController,title:String?,image:UIImage?,selectImage:UIImage?) {
        let nImage = image?.withRenderingMode(.alwaysTemplate)
        let nSelectImage = selectImage?.withRenderingMode(.alwaysTemplate)
        childViewController.title = title
        childViewController.tabBarItem = UITabBarItem(title: title, image: nImage, selectedImage: nSelectImage)
//        childViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6,left: 0,bottom: -6,right: 0)
        addChild(childViewController)
    }
}


