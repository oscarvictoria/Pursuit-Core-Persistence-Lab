//
//  Photos.swift
//  PersistenceLab
//
//  Created by Oscar Victoria Gonzalez  on 1/20/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct Photos: Codable {
    let hits: [Hits]
}

struct Hits: Codable {
    let largeImageURL: String
    let likes: Int
    let tags: String
    
    
}

extension FileManager {
    // function gets URL path to documents directory
    // FileManager.getDocumentsDirectory
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in:
            FileManager.SearchPathDomainMask.userDomainMask)[0]
    }
    
    // documents/schedules.plist "schedules.plist"
    static func pathToDocumentsDirectory(with fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
}


