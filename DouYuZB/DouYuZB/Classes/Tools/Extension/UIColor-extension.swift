//
//  UIColor-extension.swift
//  DouYuZB
//
//  Created by 刘小二 on 2017/1/18.
//  Copyright © 2017年 刘小二. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    /// 扩展的rgb构造函数 alpha 默认 1.0
    ///
    /// - Parameters:
    ///   - r: red
    ///   - g: green
    ///   - b: blue
    public convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) {
//        self.init(colorLiteralRed: Float(r), green: Float(g), blue: Float(b), alpha: 1.0)
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: CGFloat(1))
    }
    
    
    
    /// 全局的黄色
    open class var globalColor: UIColor {
    
        return UIColor(255, 128, 0)
    } // 0.0 white
    
    
    
}
