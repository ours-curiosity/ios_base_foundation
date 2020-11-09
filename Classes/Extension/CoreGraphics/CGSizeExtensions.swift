// CGSizeExtensions.swift - Copyright 2020 SwifterSwift

import CoreGraphics

// MARK: - Methods

public extension CGSize {
    /// 宽/高
    var aspectRatio: CGFloat {
        guard height != 0 else { return 0 }
        return width / height
    }
    /// 最大值
    var maxDimension: CGFloat {
        return max(width, height)
    }
    /// 最小值
    var minDimension: CGFloat {
        return min(width, height)
    }
}

// MARK: - Methods

public extension CGSize {
    /// 比例缩放后的结果，一定小于 boundingSize
    ///
    ///     let rect = CGSize(width: 120, height: 80)
    ///     let parentRect  = CGSize(width: 100, height: 50)
    ///     let newRect = rect.aspectFit(to: parentRect)
    ///     // newRect.width = 75 , newRect = 50
    ///
    /// - Parameter boundingSize: bounding size to fit self to.
    /// - Returns: self fitted into given bounding size
    func aspectFit(to boundingSize: CGSize) -> CGSize {
        let minRatio = min(boundingSize.width / width, boundingSize.height / height)
        return CGSize(width: width * minRatio, height: height * minRatio)
    }

    /// 比例填充后的结果，一定大于 boundingSize
    ///
    ///     let rect = CGSize(width: 20, height: 120)
    ///     let parentRect  = CGSize(width: 100, height: 60)
    ///     let newRect = rect.aspectFit(to: parentRect)
    ///     // newRect.width = 100 , newRect = 60
    ///
    /// - Parameter boundingSize: bounding size to fill self to.
    /// - Returns: self filled into given bounding size
    func aspectFill(to boundingSize: CGSize) -> CGSize {
        let minRatio = max(boundingSize.width / width, boundingSize.height / height)
        let aWidth = min(width * minRatio, boundingSize.width)
        let aHeight = min(height * minRatio, boundingSize.height)
        return CGSize(width: aWidth, height: aHeight)
    }
}
