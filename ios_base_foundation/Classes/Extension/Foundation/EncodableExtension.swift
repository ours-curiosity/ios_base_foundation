//
//  EncodableExtension.swift
//  CTBaseFoundation
//
//  Created by walker on 2021/4/2.
//

import Foundation

/// 遵循`Encodable`协议的对象转Data
public extension Encodable {
    /// 转Data
    /// - Returns: Data数据
    func toData() -> Data? {
        guard (self is Data) == false else { return self as? Data }
        var data: Data? = nil
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            data = try encoder.encode(self)
        }catch {
            debugPrint("⚠️ Encodable value encode to JSON error: \(error)")
        }
        return data
    }
}
