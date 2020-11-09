// DispatchQueueExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(Dispatch)
import Dispatch


// MARK: - Methods

public extension DispatchQueue {
    /// 是否为当前队列
    ///
    /// - Parameter queue: The queue to compare against.
    /// - Returns: `true` if the current queue is the specified queue, otherwise `false`.
    static func isCurrent(_ queue: DispatchQueue) -> Bool {
        let key = DispatchSpecificKey<Void>()

        queue.setSpecific(key: key, value: ())
        defer { queue.setSpecific(key: key, value: nil) }

        return DispatchQueue.getSpecific(key: key) != nil
    }
}

#endif
