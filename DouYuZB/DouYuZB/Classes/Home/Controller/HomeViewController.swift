//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by 刘小二 on 2017/1/17.
//  Copyright © 2017年 刘小二. All rights reserved.
//

import UIKit

/// pagetitleview的height
private let KTitleViewH:CGFloat = 44

class HomeViewController: UIViewController {
    // MARK:- 属性
   fileprivate lazy var pageTitleView :PageTitleView = {
        
        let frame = CGRect(x: 0, y: DYNavBarHeight, width: SCREEN_WIDTH, height: KTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"];
        let titleView = PageTitleView(frame: frame, titles: titles)
        return titleView
    
    }()
    
    // MARK:- 重写的系统的方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

   
    
}


// MARK:- 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        // 1.设置导航栏
        setupNavigationBar()
        // 2.添加titleView
        view.addSubview(pageTitleView)
    }
    
    /// 设置导航栏
    private func setupNavigationBar() {
        // 1.左侧logo
        let leftCustomBtn = UIButton(type: .custom)
        leftCustomBtn.setImage(UIImage(named:"logo"), for: .normal)
        leftCustomBtn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftCustomBtn)
        // 2.标题
        navigationItem.title = "首页"
        // 3.右侧items
        let size = CGSize(width: 40, height: 40)
        
        let hisItem = UIBarButtonItem.creatItem("image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem.creatItem("btn_search", highImageName: "btn_search_clicked", size: size)
        // 便利构造
        let scanItem = UIBarButtonItem("Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [hisItem,searchItem,scanItem]
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
