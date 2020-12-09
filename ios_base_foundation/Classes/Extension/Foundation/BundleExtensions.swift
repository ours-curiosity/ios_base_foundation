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
    ///   - className: module中的类型
    ///   - bundleName: bundle的名称
    /// - Returns: 指定的bundle
    class func bundle(className: AnyClass?, bundleName: String?) -> Bundle {
        var bundle: Bundle? = Bundle.main
        if className != nil && bundleName != nil && !bundleName!.isEmpty {
            if let bundlePath = Bundle.init(for: className!).path(forResource: bundleName, ofType: "bundle") {
                bundle = Bundle.init(path: bundlePath)
            }
        }
        return bundle ?? Bundle.main
    }
}
