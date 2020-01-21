//
//  PhotosAPIClient.swift
//  PersistenceLab
//
//  Created by Oscar Victoria Gonzalez  on 1/20/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation
import NetworkHelper

struct PhotosAPIClient {
    static func getPhotos(searchQuery: String, completion: @escaping (Result <[Hits], AppError>)-> ()) {
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "Photo"
        let endpointURLString = "https://pixabay.com/api/?key=14981312-876bca18217e0549da427823d&q=\(searchQuery)"
        
        guard let url = URL(string: endpointURLString) else {
               completion(.failure(.badURL(endpointURLString)))
               return
           }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let photos = try JSONDecoder().decode(Photos.self, from: data)
                    completion(.success(photos.hits))
                } catch {
                    
                }
            }
        }
    }
}
