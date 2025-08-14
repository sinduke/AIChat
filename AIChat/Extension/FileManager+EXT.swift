//
//  FileManager+EXT.swift
//  AIChat
//
//  Created by sinduke on 8/13/25.
//

import SwiftUI

extension FileManager {
    /// 保存 Codable 数据模型到 Documents 目录
    static func saveDocument<T: Codable>(
        key: String,
        value: T?,
        nilDeletes: Bool = false,
        ext: String = "txt"
    ) throws {
        let fileURL = try documentURL(forKey: key, ext: ext)
        
        if value == nil, nilDeletes {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
            }
            return
        }
        
        let data = try JSONEncoder().encode(value) // nil 会被编码为 JSON 的 null
        try data.write(to: fileURL, options: .atomic)
    }
    
    /// 读取 Documents 目录中的 Codable 数据模型（自动类型推断）
    static func getDocument<T: Codable>(
        key: String,
        ext: String = "txt"
    ) throws -> T? {
        let fileURL = try documentURL(forKey: key, ext: ext)
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return nil }
        
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode(T.self, from: data)
    }

    /// 获取带文件名的完整 Documents 路径
    private static func documentURL(forKey key: String, ext: String) throws -> URL {
        guard let documentDirectory = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first
        else {
            throw FilePersistError.documentDirectoryNotFound
        }
        return documentDirectory.appendingPathComponent("\(key).\(ext)")
    }
    
    enum FilePersistError: Error {
        case documentDirectoryNotFound
    }
    
}
