
import Foundation

public extension Data {
    /// 一组 bytes 数据
    var bytes: [UInt8] {
        // http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
        return [UInt8](self)
    }
}

public extension Data {
    /// 转string
    func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    /// 转json
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }
}

public extension Data {
    
    /// json 二进制 转模型
    /// - Parameter type: 类型
    /// - Returns: 转换后的模型
    func toModel<T>(_ type: T.Type) -> T? where T: Codable {
        var model: T? = nil
        do {
            model = try JSONDecoder().decode(type, from: self)
        }catch {
            DebugPrint("Data convertModel error: \(error)")
        }
        return model
    }
}
