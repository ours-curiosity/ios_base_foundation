//
//  BundleExtensions.swift
//  CTBaseFoundation
//
//  Created by walker on 2020/12/9.
//

import Foundation
public extension Bundle {
    
    /// 生成指定的bundle
    /// - Parameters:
    ///   - classType: module中某个类的类型
    ///   - bundleName: bundle的名称
    /// - Returns: 指定的bundle
    class func bundle(classType: AnyClass?, bundleName: String?) -> Bundle {
        var bundle: Bundle? = Bundle.main
        if classType != nil && bundleName != nil && !bundleName!.isEmpty {
            if let bundlePath = Bundle.init(for: classType!).path(forResource: bundleName, ofType: "bundle") {
                bundle = Bundle.init(path: bundlePath)
            }
        }
        return bundle ?? Bundle.main
    }
}
