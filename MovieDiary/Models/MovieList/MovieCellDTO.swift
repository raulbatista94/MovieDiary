//
//  MovieCellDTO.swift
//  MovieDiary
//
//  Created by Raul on 09/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//


struct MovieCellDTO: Decodable {
    let id: Int
    let title: String
    let posterPath: String
    let cellImagePath: String?
    let averageScore: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case posterPath = "poster_path"
        case cellImagePath = "backdrop_path"
        case averageScore = "vote_average"
        case overview = "overview"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.cellImagePath = try? container.decode(String.self, forKey: .cellImagePath)
        self.averageScore = try container.decode(Double.self, forKey: .averageScore)
    }
}
