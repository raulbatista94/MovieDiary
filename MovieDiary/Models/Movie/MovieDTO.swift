//
//  MovieDTO.swift
//  MovieDiary
//
//  Created by Raul on 09/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//


struct MovieDTO: Decodable {
    let title: String
    let posterPath: String
    let averageScore: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case posterPath = "poster_path"
        case averageScore = "vote_average"
        case overview = "overview"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.averageScore = try container.decode(Double.self, forKey: .averageScore)
        self.overview = try container.decode(String.self, forKey: .overview)
    }
}
