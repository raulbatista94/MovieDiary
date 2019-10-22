//
//  MovieDetailDTO.swift
//  MovieDiary
//
//  Created by Raul on 22/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation
struct MovieDetailDTO: Decodable {
    let id: Int
    let title: String
    let posterPath: String
    let cellImagePath: String?
    let averageScore: Double
    let overview: String
    let genres: [MovieGenreDTO]
    let releaseDate: String
    let duration: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case posterPath = "poster_path"
        case cellImagePath = "backdrop_path"
        case averageScore = "vote_average"
        case overview
        case genres
        case releaseDate = "release_date"
        case duration = "runtime"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.cellImagePath = try? container.decode(String.self, forKey: .cellImagePath)
        self.averageScore = try container.decode(Double.self, forKey: .averageScore)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.genres = try container.decode([MovieGenreDTO].self, forKey: .genres)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.duration = try container.decode(Int.self, forKey: .duration)
    }
}
