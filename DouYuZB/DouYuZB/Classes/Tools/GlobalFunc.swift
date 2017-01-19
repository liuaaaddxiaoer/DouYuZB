//
//  GlobalFunc.swift
//  DouYuZB
//
//  Created by 刘小二 on 2017/1/18.
//  Copyright © 2017年 刘小二. All rights reserved.
//  全局函数

import UIKit

/// 全局的DEBUG模式下的打印
///
/// - Parameters:
///   - message: 需要打印的消息
///   - file: 打印所在的文件
///   - line: 打印所在的函数的行数 可以使用 command + shift o 快速跳转到文件再使用 command+L跳转到对应的行数
public func DYPrint<T>(_ message: T, file:String = #file, line:Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("函数所在文件:\(fileName)---函数所在行数:\(line)---对应打印数据:\(message)")
    #endif
}


