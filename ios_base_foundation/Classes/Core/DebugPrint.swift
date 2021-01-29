//
//  DebugPrint.swift
//  Building6
//
//  Created by Quinn on 2020/8/18.
//  Copyright © 2020 funlink-tech. All rights reserved.
//

import Foundation

/// - Parameters:
///   - items: Zero or more items to print.
///   - separator: A string to print between each item. The default is a single space (`" "`).
///   - terminator: The string to print after all items have been printed. The  default is a newline (`"\n"`).
///   - file: 文件名，默认值：#file
///   - line: 第几行，默认值：#line
///   - method: 函数名，默认值：#function
public func DebugPrint(_ items: Any...,
                       canPrint: Bool = true,
                       separator: String = " ",
                       terminator: String = "\n",
                       file: String = #file,
                       line: Int = #line,
                       method: String = #function)
{
    if !canPrint { // 不允许打印，直接返回
        return
    }
    #if DEBUG || BETADEBUG
    //如果不怕打印结果有大括号[4, "abc", [1, 2, 3]]，可以直接一句话
    //print("\((file as NSString).lastPathComponent)[\(line)], \(method):", items)
    print("\((file as NSString).lastPathComponent)[\(line)], \(method):", terminator: separator)
    var i = 0
    let j = items.count
    for a in items {
        i += 1
        print(a, terminator:i == j ? terminator: separator)
    }
    #endif
}
