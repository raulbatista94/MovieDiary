//
//  MovieGenre.swift
//  MovieDiary
//
//  Created by Raul on 20/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation

struct MovieGenre {
    let id: Int
    let name: String
}

struct MovieGenresContainer: Decodable {
    let genres: [MovieGenreDTO]
}
