//
//  MovieTrailerDTO.swift
//  MovieDiary
//
//  Created by Raul on 20/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation

struct MovieTrailerDTO: Decodable {
    let id: String
    let trailerYouTubeID: String
    let name: String
    let site: String
    let size: Int
        
    enum CodingKeys: String, CodingKey {
        case id
        case trailerYoutTubeID = "key"
        case name
        case site
        case size
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.trailerYouTubeID = try container.decode(String.self, forKey: .trailerYoutTubeID)
        self.name = try container.decode(String.self, forKey: .name)
        self.site = try container.decode(String.self, forKey: .site)
        self.size = try container.decode(Int.self, forKey: .size)
    }
}

struct MovieTrailersContainerDTO: Decodable {
    let id: Int
    let results: [MovieTrailerDTO]
}
