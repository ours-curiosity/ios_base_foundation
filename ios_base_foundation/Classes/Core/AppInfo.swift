//
//  SpeedyApp.swift
//  Building6
//
//  Created by Quinn on 2020/8/18.
//  Copyright © 2020 funlink-tech. All rights reserved.
//

import Foundation

public struct AppInfo {
    
    /// 打印设备详细信息
    public static func log() {
        let str = "-------------------App信息-------------------"
        let infoStr = "\n \(str) \n \(info) \n \(str) \n"
        DebugPrint(infoStr)
    }
    
    /// 设备信息
    public static var info: String {
        let infoStr = "\n 版本号: \(version) \n Build号: \(buildVersion) \n APP名称: \(displayName) \n 唯一标识: \(bundleId)"
        return infoStr
    }
    
    /// 发布的版本号 如：2.1.1
    public static var version: String {
        if let str = self.plistDict()["CFBundleShortVersionString"] as? String {
            return str
        }
        return ""
    }
    
    /// build号
    public static var buildVersion: String {
        
        if let str = self.plistDict()["CFBundleVersion"] as? String {
            return str
        }
        return ""
    }
    
    /// 名称 如：抖音
    public static var displayName: String {
        if let str = self.plistDict()["CFBundleDisplayName"] as? String {
            return str
        }
        return ""
    }
    
    // bundleId
    public static var bundleId: String {
        // app的bundle id
        if let str = self.plistDict()["CFBundleIdentifier"] as? String {
            return str
        }
        return ""
    }
    
    /// plist 详情
    /// - Returns: 基本信息的字典
    public static func plistDict() -> [String: Any]! {
        var infoDict: [String: Any]? = Bundle.main.infoDictionary
        if infoDict == nil || infoDict!.count <= 0 {
            infoDict = Bundle.main.localizedInfoDictionary
        }
        if infoDict == nil || infoDict!.count <= 0 {
            let path = Bundle.main.path(forResource: "Info", ofType: "plist") ?? ""
            infoDict = NSDictionary.init(contentsOfFile: path) as? [String : Any]
        }
        return infoDict ?? [:]
    }
    
}

