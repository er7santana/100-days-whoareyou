//
//  FileManager+Extension.swift
//  WhoAreYou
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 10/08/24.
//

import Foundation

extension FileManager {
    
    static let savePath = URL.documentsDirectory.appending(path: "SavedPeople")
    
    static func write<T: Codable>(content: T) throws {
        let data = try JSONEncoder().encode(content)
        try data.write(to: savePath, options: [.atomic, .completeFileProtection])
    }
    
    static func read<T: Codable>() throws -> T {
        let data = try Data(contentsOf: savePath)
        let content = try JSONDecoder().decode(T.self, from: data)
        return content
    }
}
