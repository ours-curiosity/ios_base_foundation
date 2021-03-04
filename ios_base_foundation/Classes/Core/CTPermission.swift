//
//  CTPermission.swift
//  CTBaseFoundation
//
//  Created by 2020 on 2021/1/11.
//

import Foundation
import AVFoundation
@objcMembers
public class CTPermission:NSObject{
    /// 请求麦克风权限
    public static func requestMicPhone(success:@escaping (()->Void),failed:@escaping (()->Void)){
        let mediaType = AVMediaType.audio
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        if authorizationStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: .audio) { (isGrant) in
                DispatchQueue.main.async {
                    if isGrant == true {
                        success()
                    }else{
                        failed()
                    }
                }
            }
        }else if authorizationStatus == .authorized {
            success()
        }else {
            failed()
        }
    }
}
