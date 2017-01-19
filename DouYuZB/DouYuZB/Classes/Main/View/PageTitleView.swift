//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by 刘小二 on 2017/1/17.
//  Copyright © 2017年 刘小二. All rights reserved.
//

import UIKit
// MARK:- PageTitleViewDelegate
protocol PageTitleViewDelegate: class {
    
    /// 点击标题的回调
    ///
    /// - Parameters:
    ///   - titleView: PageTitleView
    ///   - index: 点击标题的索引
    func pageTitleView(titleView: PageTitleView, index: Int)
}


// MARK:- 一些常量 private
/// 滚动滑块的高
private let KSCrolLineH : CGFloat = 2
/// 标题文字默认大小
private let KTitleFont : CGFloat = 15
/// 底部线的高
private let KLineH : CGFloat = 0.5
/// 标题文字默认未选中的颜色
private let KTitleColor : UIColor = UIColor(85, 85, 85)

private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {

    // MARK:- 自定义属性
    /// 当前显示的label的索引
    fileprivate var currentIndex: Int = 0
    /// 标题文字对应的数组
    fileprivate var titles: [String]
    /// 代理
    public weak var delegate: PageTitleViewDelegate?
    /// 滚动条
    fileprivate var scrolLines: UIView?
    // MARK:- 懒加载属性
    /// 标题label数组
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    /// titleview中对应的能滚动的scrollview
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = false
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.clipsToBounds = false
        return scrollView
    }()
    
    // MARK:- 构造方法
    init(frame: CGRect , titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
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
        // 3.添加线和滑动的线
        setupBottomLineAndScrolLine()
    }
    /// 3 设置titleview上的label
   
    private func setupTitleLabels() {
        //  3.0 设置frame相关
        let labelW = frame.width / CGFloat(titles.count)
        let labelY:CGFloat = 0
        let labelH = frame.height - KSCrolLineH
        for (index, title) in titles.enumerated() {
            //3.1创建label
            let label = UILabel()
            //3.2设置frame
            let labelX = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //3.3设置label的属性
            label.text = title
            label.textColor = KTitleColor
            label.font = UIFont.systemFont(ofSize: KTitleFont)
            label.textAlignment = .center
            label.tag = index
            //4.添加
            scrollView.addSubview(label)
            titleLabels.append(label)
            //5.添加手势
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleClick(tapGes:)))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(tapGes)
            if (index == 0) {
                self.titleClick(tapGes: tapGes)
            }
           
        }
        guard let firstLabel = titleLabels.first else {
            
            DYPrint("错")
            
            return
        }
        firstLabel.textColor = UIColor.globalColor
        
        
    }
    
    /// 添加线和滑动的线
    private func setupBottomLineAndScrolLine() {
        
        // 1.底部的线
        let lineX : CGFloat = 0
        let lineH = KLineH
        let lineY = frame.height - lineH
        let lineW = frame.width
        let line = UIView(frame: CGRect(x: lineX, y: lineY, width: lineW, height: lineH))
        // 1.1设置属性
        line.backgroundColor = KTitleColor
        // 1.2添加line
        addSubview(line)
        // 2.滑动的线
        let scrolLineX : CGFloat = 0
        let scrolLineH = KSCrolLineH
        let scrolLineW = SCREEN_WIDTH / CGFloat(titles.count)
        let scrolLineY = frame.height - KSCrolLineH
        let scrolLine = UIView(frame: CGRect(x: scrolLineX, y: scrolLineY, width: scrolLineW, height: scrolLineH))
        // 2.1设置属性
        scrolLine.backgroundColor = UIColor.globalColor
        self.scrolLines = scrolLine
        // 2.2添加scrolLine
        addSubview(scrolLine)
    }
}

// MARK:- label的的点击事件
extension PageTitleView {
    @objc fileprivate func titleClick(tapGes: UITapGestureRecognizer) {
        // 获取当前点击的label
        guard  let currentLabel = tapGes.view as? UILabel else {
            
            print("haha")
            return
        }
        
        // 1.如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        // 设置当前点击label的文字颜色
        currentLabel.textColor = UIColor.globalColor
        // 设置之前点击的文字的颜色
        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = KTitleColor
        // 设置新的当前索引
        currentIndex = currentLabel.tag
        // 设置滚动条的位置
        UIView.animate(withDuration: 0.15, animations: {
            self.scrolLines?.frame.origin.x = (self.scrolLines?.frame.width)! * CGFloat(self.currentIndex)
        })
        
        // 代理方法
        self.delegate?.pageTitleView(titleView: self, index: currentIndex)
    }
}



// MARK:- public
extension PageTitleView {

    func setupTitleColorChange(progress: CGFloat, targetIndex: Int, sourceIndex: Int) {
        // 更改滚动条的颜色
        let targetLabel = titleLabels[targetIndex]
        let sourceLabel = titleLabels[sourceIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = progress * moveTotalX
        
        scrolLines?.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor( kSelectColor.0 - colorDelta.0 * progress, kSelectColor.1 - colorDelta.1 * progress,  kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(kNormalColor.0 + colorDelta.0 * progress, kNormalColor.1 + colorDelta.1 * progress, kNormalColor.2 + colorDelta.2 * progress)
        
//        DYPrint("\(kNormalColor.0 + colorDelta.0 * progress) + \(kNormalColor.1 + colorDelta.1 * progress) + \(kNormalColor.2 + colorDelta.2 * progress)")
        
        currentIndex = targetIndex
    }
}
