// FileManagerExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension FileManager {
    /// 从file中读取json
    ///
    /// - Parameters:
    ///   - path: JSON file path.
    ///   - readingOptions: JSONSerialization reading options.
    /// - Returns: Optional dictionary.
    /// - Throws: Throws any errors thrown by Data creation or JSON serialization.
    func jsonFromFile(
        atPath path: String,
        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]? {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)
        
        return json as? [String: Any]
    }
    
    
    /// 创建一个保存临时文件的唯一目录
    ///
    ///     let tempDirectory = try fileManager.createTemporaryDirectory()
    ///     let tempFile1URL = tempDirectory.appendingPathComponent(ProcessInfo().globallyUniqueString)
    ///     let tempFile2URL = tempDirectory.appendingPathComponent(ProcessInfo().globallyUniqueString)
    ///
    /// - Returns: A URL to a new directory for saving temporary files.
    /// - Throws: An error if a temporary directory cannot be found or created.
    func createTemporaryDirectory() throws -> URL {
        let envs = ProcessInfo.processInfo.environment
        let env = envs["TMPDIR"] ?? envs["TEMP"] ?? envs["TMP"] ?? "/tmp"
        let dir = "/\(env)/file-temp.XXXXXX"
        var template = [UInt8](dir.utf8).map { Int8($0) } + [Int8(0)]
        guard mkdtemp(&template) != nil else { throw CocoaError.error(.featureUnsupported) }
        return URL(fileURLWithPath: String(cString: template))
    }
}

#endif
