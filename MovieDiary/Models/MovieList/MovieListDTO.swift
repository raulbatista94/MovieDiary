//
//  MovieListDTO.swift
//  MovieDiary
//
//  Created by Raul on 09/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

struct MovieListDTO: Decodable {
    let page: Int?
    let results: [MovieDTO]
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.results = try container.decode([MovieDTO].self, forKey: .results)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
    }
}
