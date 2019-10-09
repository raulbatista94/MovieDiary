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
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
    }
}
