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
