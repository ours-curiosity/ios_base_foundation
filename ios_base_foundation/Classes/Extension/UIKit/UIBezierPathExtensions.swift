// UIBezierPathExtensions.swift - Copyright 2020 SwifterSwift

import UIKit

// MARK: - Initializers

public extension UIBezierPath {
    /// 两点连线
    ///
    /// - Parameters:
    ///   - from: The point from which to path should start.
    ///   - to: The point where the path should end.
    convenience init(from: CGPoint, to otherPoint: CGPoint) {
        self.init()
        move(to: from)
        addLine(to: otherPoint)
    }

    /// 用直线连接给定的CGPoints
    ///
    /// - Parameter points: The points of which the path should consist.
    convenience init(points: [CGPoint]) {
        self.init()
        if !points.isEmpty {
            move(to: points[0])
            for point in points[1...] {
                addLine(to: point)
            }
        }
    }

    /// 使用给定的CGPoints初始化多边形UIBezierPath。最少得3个。
    ///
    /// - Parameter points: The points of the polygon which the path should form.
    convenience init?(polygonWithPoints points: [CGPoint]) {
        guard points.count > 2 else { return nil }
        self.init()
        move(to: points[0])
        for point in points[1...] {
            addLine(to: point)
        }
        close()
    }

    /// 用给定大小的椭圆路径初始化UIBezierPath。
    ///
    /// - Parameters:
    ///   - size: The width and height of the oval.
    ///   - centered: Whether the oval should be centered in its coordinate space.
    convenience init(ovalOf size: CGSize, centered: Bool) {
        let origin = centered ? CGPoint(x: -size.width / 2, y: -size.height / 2) : .zero
        self.init(ovalIn: CGRect(origin: origin, size: size))
    }

    /// 用给定大小的矩形路径初始化UIBezierPath。
    ///
    /// - Parameters:
    ///   - size: The width and height of the rect.
    ///   - centered: Whether the oval should be centered in its coordinate space.
    convenience init(rectOf size: CGSize, centered: Bool) {
        let origin = centered ? CGPoint(x: -size.width / 2, y: -size.height / 2) : .zero
        self.init(rect: CGRect(origin: origin, size: size))
    }
}
