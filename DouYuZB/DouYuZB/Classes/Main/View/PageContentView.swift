//
//  PageContentView.swift
//  DouYuZB
//
//  Created by 刘小二 on 2017/1/18.
//  Copyright © 2017年 刘小二. All rights reserved.
//

import UIKit


// MARK:- 常量
/// collection的ID
private let collectionViewID = "collectionViewID"
// MARK:- PageContentViewDelegate
protocol PageContentViewDelegate: class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, targetIndex: Int, sourceIndex: Int)
}

class PageContentView: UIView {
    
    // MARK:- 属性
    /// 子控制器数组
    fileprivate var childVcs: [UIViewController]
    /// 父控制器
    fileprivate weak var parentVC: UIViewController?
    // 起始偏移
    fileprivate var startOffset: CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    /// PageContentViewDelegate
    public weak var delegate: PageContentViewDelegate?
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = { [unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.frame.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        // 2.创建collectionView
        let collecView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collecView.delegate = self
        collecView.dataSource = self
        collecView.bounces = false
        collecView.showsHorizontalScrollIndicator = false
        collecView.isPagingEnabled = true
        collecView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewID)
        return collecView
        
    }()
    
    // MARK:- 构造函数
    
    /// 自定义的构造函数
    ///
    /// - Parameters:
    ///   - frame: 传入PageContentView的frame
    ///   - childVcs: 所有的子控制器数组
    ///   - parentVC: 子控制器的父控制器
    init(frame: CGRect, childVcs: [UIViewController], parentVC: UIViewController) {
        self.childVcs = childVcs
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        // 添加子控件
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK:- 设置UI界面
extension PageContentView {
    /// 设置UI
    fileprivate func setupUI() {
        // 1.将所有子控制器添加到parent中
        for childVc in childVcs {
            parentVC?.addChildViewController(childVc)
        }
        // 2.加载UICollectionView
        addSubview(collectionView)
    }
}

// MARK:- UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewId = collectionViewID
        let cv = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewId, for: indexPath)
        // 移除view
        for view in cv.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cv.contentView.bounds
        // 添加view
        cv.contentView.addSubview(childVc.view)
        return cv
    }
}

extension PageContentView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        // 起始偏移用来判断移动的方向
        isForbidScrollDelegate = false
        startOffset = scrollView.contentOffset.x
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate { return }
        let offset = scrollView.contentOffset.x
        
        
        
        // 滚动的进度
        var progress: CGFloat = 0
        // 从哪里滚来
        var sourceIndex: Int = 0
        // 目标索引
        var targetIndex: Int = 0
        
        
        // 向左滑
        if (offset > startOffset) {
            // 计算滚动的进度        floor 向下取整
            progress = offset/scrollView.bounds.width - floor(offset/scrollView.bounds.width)
            // 取整目标索引
            sourceIndex = Int(offset/scrollView.bounds.width)
            // 目标
            targetIndex = sourceIndex + 1
            if (targetIndex >= childVcs.count) {
                targetIndex = childVcs.count - 1
            }
            
            DYPrint(offset - startOffset)
            
            if (offset - startOffset == scrollView.bounds.width) {
                progress = 1
                 targetIndex = sourceIndex
            }
            
//            DYPrint("左---\(sourceIndex)")
        // 向右滑
        }else {
            progress = 1 - (offset/scrollView.bounds.width - floor(offset/scrollView.bounds.width))
            // 目标
            targetIndex = Int(offset/scrollView.bounds.width)
            // 从哪里滚来
            sourceIndex = targetIndex + 1
            if (sourceIndex >= childVcs.count) {
                sourceIndex = childVcs.count - 1
            }
//            DYPrint("右---\(sourceIndex)")
        }
        
        // 代理
        delegate?.pageContentView(contentView: self, progress: progress, targetIndex: targetIndex, sourceIndex: sourceIndex)
    }
    
}

// MARK:- public
extension PageContentView {
    
    func setContentOffset(index: Int) {
        isForbidScrollDelegate = true
        collectionView.setContentOffset(CGPoint(x: index * Int(SCREEN_WIDTH), y: 0), animated: true)
    }
}








