// DecodableExtensions.swift - Copyright 2020 SwifterSwift

import Foundation
public extension Decodable {
    /// SwifterSwift: Parsing the model in Decodable type
    /// - Parameters:
    ///   - data: Data.
    ///   - decoder: JSONDecoder. Initialized by default
    init?(from data: Data, using decoder: JSONDecoder = .init()) {
        guard let parsed = try? decoder.decode(Self.self, from: data) else { return nil }
        self = parsed
    }
}
