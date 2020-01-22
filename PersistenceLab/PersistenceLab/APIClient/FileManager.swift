//
//  FileManager.swift
//  PersistenceLab
//
//  Created by Oscar Victoria Gonzalez  on 1/21/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

enum DataPersistanceError: Error { // conforming to the Error protocol
    case savingError(Error) // associative value
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistanceHelper {
    // CRUD - create, read, update, delete
    
    private static var photos = [Hits]()
    
    private static let filename = "photos.plist"
    
    // create - save item to documents directory
    
    private static func save() throws {
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // append new event to the events array
        
        // events array will be object being converted to data
        // we will use the data object and write (save) it to documents directory
        do {
            // convert (serialize) the events array to Data
            let data = try PropertyListEncoder().encode(photos)
            
            // writes, saves, persist the data to the documents directory
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistanceError.savingError(error)
        }
    }
    
    
    static func save(pictures: Hits) throws {
//        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // append new event to the events array
        photos.append(pictures)
        
        try save()
        
        do {
            try save()
        } catch {
            throw DataPersistanceError.savingError(error)
        }
        
        // events array will be object being converted to data
        // we will use the data object and write (save) it to documents directory
    
    }
    
    // read - load (retrieve) items from documents directory
    static func loadEvents() throws -> [Hits]  {
        // we need access to the filename url that we are reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // check if file exist
        // to convert URL to string we use .path on the url
        if FileManager.default.fileExists(atPath: url.path) {
            
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    photos = try PropertyListDecoder().decode([Hits].self, from: data)
                } catch {
                    throw DataPersistanceError.decodingError(error)
                }
            } else {
               throw DataPersistanceError.noData
            }
           
        } else {
            throw DataPersistanceError.fileDoesNotExist(filename)
        }
         return photos
    }
        
        // update -
        
        
        // delete - remove items from documents directory
    static func delete(photos index: Int) throws {
        photos.remove(at: index)
        
        // save our events array to the documents directory
        do {
           try save()
        } catch {
            throw DataPersistanceError.deletingError(error)
        }
    }

}

