//
//  UIBarButtonItem-extension.swift
//  DouYuZB
//
//  Created by 刘小二 on 2017/1/17.
//  Copyright © 2017年 刘小二. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 快速创建一个UIBarButtonItem
    ///
    /// - Parameters:
    ///   - imageName: 图片名字
    ///   - highImageName: 高亮图片名字
    ///   - size: 图片尺寸
    /// - Returns: 返回一个自定义的UIBarButtonItem
    public class func creatItem(_ imageName:String, highImageName:String, size: CGSize) -> UIBarButtonItem {
    
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: .zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    
    /// 便利构造函数创建一个UIBarButtonItem
    ///
    /// - Parameters:
    ///   - imageName: 图片名字
    ///   - highImageName: 高亮图片名字
    ///   - size: 图片尺寸
    ///   创建一个自定义的UIBarButtonItem
    public convenience init(_ imageName:String, highImageName:String = "", size: CGSize = .zero) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if (highImageName != "") {
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if (size == .zero) {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: .zero, size: size)
        }
        self.init(customView: btn)
    }
}
