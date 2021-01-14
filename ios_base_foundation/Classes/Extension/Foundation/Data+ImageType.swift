//
//  Data+ImageType.swift
//  CTBaseFoundation
//
//  Created by walker on 2021/1/14.
//

import UIKit

public enum CTImageType {
    case Unknow// 未知
    case JPEG   // image/jpeg
    case PNG    // image/png
    case GIF    // image/gif
    case WebP   // image/webp
    case BMP    // image/bmp
    case TIFF   // image/tiff
    case HEIC
    case HEIF
}

extension CTImageType {
    func ct_contentType() -> String {
        switch self {
        case .JPEG:
            return "image/jpeg"
        case .PNG:
            return "image/png"
        case .GIF:
            return "image/gif"
        case .WebP:
            return "image/webp"
        case .BMP:
            return "image/bmp"
        case .TIFF:
            return "image/tiff"
        default:
            return "application/octet-stream"
        }
    }
    
    func ct_extensionName() -> String {
        switch self {
        case .JPEG:
            return "jpeg"
        case .PNG:
            return "png"
        case .GIF:
            return "gif"
        case .WebP:
            return "webp"
        case .BMP:
            return "bmp"
        case .TIFF:
            return "tiff"
        case .HEIC:
            return "heic"
        case .HEIF:
            return "heif"
        default:
            return "application/octet-stream"
        }
    }
}

extension Data {
    
    /// type for image data
    /// - Returns: ImageType
    public func ct_imageType() -> CTImageType {
        var type = CTImageType.Unknow
        
        var c: UInt8 = 0xFF
        self.copyBytes(to: &c, count: 1)
        
        switch c {
        case 0xFF:
            type = .JPEG
        case 0x89:
            type = .PNG
        case 0x47:
            type = .GIF
        case 0x49,0x4D:
            type = .TIFF
        case 0x42:
            type = .BMP
        case 0x52:
            if (self.count < 12) {
                type = .Unknow;
                break
            }
            if let headInfo = String(data: self[0...11], encoding: String.Encoding.ascii), headInfo.hasPrefix("RIFF"), headInfo.hasSuffix("WEBP") {
                type = .WebP
                break
            }else {
                type = .Unknow
                break
            }
            
        case 0x00 where self.count >= 12:
            if let headInfo = String(data: self[8...11], encoding: .ascii) {
                let HEICBitMaps = Set(["heic", "heis", "heix", "hevc", "hevx"])
                if HEICBitMaps.contains(headInfo) {
                    return .HEIC
                }
                let HEIFBitMaps = Set(["mif1", "msf1"])
                if HEIFBitMaps.contains(headInfo) {
                    return .HEIF
                }
            }
        default:
            type = .Unknow
        }
        return type
    }
}
