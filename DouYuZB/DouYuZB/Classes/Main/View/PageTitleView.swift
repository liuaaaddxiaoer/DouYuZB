//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by 刘小二 on 2017/1/17.
//  Copyright © 2017年 刘小二. All rights reserved.
//

import UIKit

class PageTitleView: UIView {

    // MARK:- 自定义属性
    /// 标题对应的数组
    fileprivate var titles:[String]
    // MARK:- 懒加载属性
    /// titleview中对应的能滚动的scrollview
    fileprivate lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = false
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    
    // MARK:- 构造方法
    init(frame: CGRect , titles:[String]) {
        
        self.titles = titles
        super.init(frame: frame)
        backgroundColor = UIColor.red
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 设置UI界面
extension PageTitleView {
    
    /// 设置UI界面
    fileprivate func setupUI() {
        // 1.添加UIScrollview
        addSubview(scrollView)
        // 1.1设置scrollView的frame(可视范围）
        scrollView.frame = bounds
        // 2.添加titleview上的label
        setupTitleLabels()
    }
    /// 设置titleview上的label
    private func setupTitleLabels() {
        for (index, title) in titles.enumerated() {
            DYPrint("index= \(title) \n")
        }
    }
}
