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
    // MARK:- 懒加载属性
    /// pageTitleView
   fileprivate lazy var pageTitleView: PageTitleView = {
        
        let frame = CGRect(x: 0, y: DYNavBarHeight, width: SCREEN_WIDTH, height: KTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"];
        let titleView = PageTitleView(frame: frame, titles: titles)
        titleView.delegate = self
        return titleView
    
    }()
    
    fileprivate lazy var pageContentView: PageContentView = { [unowned self] in
        // 1. 设置contentvew的frame
        let contentY = self.pageTitleView.frame.maxY
        let contentFrame = CGRect(x: 0, y: contentY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - contentY)
        // 2. 设置childVcs
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(CGFloat(arc4random_uniform(255)), CGFloat( arc4random_uniform(255)), CGFloat( arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVC: self)
        contentView.delegate = self
        return contentView
        
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
        // 0取消scrollview的偏移64
        automaticallyAdjustsScrollViewInsets = false
        // 1.设置导航栏
        setupNavigationBar()
        // 2.添加titleView
        view.addSubview(pageTitleView)
        // 3.添加contentView
        view.addSubview(pageContentView)
        
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


// MARK:- PageTitleViewDelegate
extension HomeViewController: PageTitleViewDelegate {

    func pageTitleView(titleView: PageTitleView, index: Int) {
        pageContentView.setContentOffset(index: index)
    }
}
// MARK:- PageContentViewDelegate
extension HomeViewController: PageContentViewDelegate {
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, targetIndex: Int, sourceIndex: Int) {
        //更改pageTitleView的状态
        pageTitleView.setupTitleColorChange(progress: progress, targetIndex: targetIndex, sourceIndex: sourceIndex)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
