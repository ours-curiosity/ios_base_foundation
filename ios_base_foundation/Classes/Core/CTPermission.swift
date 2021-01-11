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
    public static func requestMicPhone(success:@escaping (()->Void),failed:@escaping (()->Void)){
        let mediaType = AVMediaType.audio
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        if authorizationStatus == .notDetermined{
            AVCaptureDevice.requestAccess(for: .audio) { (result) in
                DispatchQueue.main.async {
                    if result {
                        success()
                    }else{
                        failed()
                    }
                }
            }
        }else if authorizationStatus != .authorized{
            failed()
        }else{
            success()
        }
    }
}
