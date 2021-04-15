// UIImageExtensions.swift - Copyright 2020 SwifterSwift

import UIKit

// MARK: - Properties

public extension UIImage {
    /// 大小 单位 kb
    var bytesSize: Int {
        return (self.jpegData(compressionQuality: 1)?.count ?? 0) / 1024
    }
    
    /// SwifterSwift: UIImage with .alwaysOriginal rendering mode.
    var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    /// SwifterSwift: UIImage with .alwaysTemplate rendering mode.
    var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
}
public extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) {
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        context?.setShouldAntialias(true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        guard let cgImage = image?.cgImage else {
            self.init()
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
    convenience init?(base64String: String, scale: CGFloat = 1.0) {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        self.init(data: data, scale: scale)
    }
    /// 质量压缩
    func compress(maxSize: Int) -> Data? {
        var compression: CGFloat = 1
        guard var data = self.jpegData(compressionQuality: 1) else { return nil }
        if data.count < maxSize {
            return data
        }
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = self.jpegData(compressionQuality: compression)!
            if CGFloat(data.count) < CGFloat(maxSize){
                min = compression
            } else if data.count > maxSize {
                max = compression
            } else {
                break
            }
        }
        return data
    }
    
    /// 根据尺寸重新生成图片
    ///
    /// - Parameter size: 设置的大小
    /// - Returns: 新图
    func compress(maxLength: CGFloat) -> UIImage? {
        
        if maxLength <= 0 {
            return self
        }
        
        var imgMax:CGFloat = 0
        if self.size.width/self.size.height >= 1{
            imgMax = self.size.width
        }else{
            imgMax = self.size.height
        }
        if imgMax > maxLength {
            let ratio = maxLength/imgMax
            let newW  = self.size.width * ratio
            let newH  = self.size.height * ratio
            
            let newSize = CGSize(width: newW, height: newH)
            UIGraphicsBeginImageContext(newSize)
            self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            guard let _img = img else { return  nil}
            return _img
        }else{
            return self
        }
    }
    /// 切圆角
    ///
    /// - Parameters:
    ///   - radius: corner radius (optional), resulting image will be round if unspecified
    /// - Returns: UIImage with all corners rounded
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0, radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

public extension UIImage {
    /// 加载bundle中的图片
    /// - Parameters:
    ///   - name: 图片名称
    ///   - bundleForClass: 类型
    ///   - bundleName: bundle名称
    /// - Returns: 指定bundle下的图片对象
    class func imageNamed(_ name: String?, bundleForClass: AnyClass?, bundleName: String? = nil) -> UIImage? {
        var bundle: Bundle? = nil
        if bundleForClass != nil && bundleName != nil {
            if let bundlePath = Bundle.init(for: bundleForClass!).path(forResource: bundleName, ofType: "bundle") {
                bundle = Bundle.init(path: bundlePath)
            }
        }
        return UIImage.init(named: name ?? "", in: bundle, compatibleWith: nil)
    }
}

public extension UIImage {
    
    /// 返回当前图片的灰度图片，黑底(walker)
    /// - Returns: 转换后的灰度图片
    func ct_greyScaleImage() -> UIImage? {
        guard let imageRef = self.cgImage else { return nil }
        let width:Int = imageRef.width
        let height:Int = imageRef.height
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let context:CGContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        let rect:CGRect = CGRect.init(x: 0, y: 0, width: width, height: height)
        context.draw(imageRef, in: rect)
        guard let outPutImage:CGImage = context.makeImage() else { return nil }
        let grayImage = UIImage.init(cgImage: outPutImage, scale: self.scale, orientation: self.imageOrientation)
        return grayImage
    }
    
    /// 返回当前图片的灰度图片，带alpha (walker)
    /// - Returns: 转换后的灰度图片
    func ct_greyScaleAlphaImage() -> UIImage? {
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIPhotoEffectTonal") {
            filter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
            if let output = filter.outputImage {
                if let cgImage = context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return nil
    }
}
