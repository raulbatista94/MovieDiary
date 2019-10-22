//
//  MovieDetail.swift
//  MovieDiary
//
//  Created by Raul on 22/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation

struct MovieDetail {
    let id: Int
    let title: String
    let posterPath: String
    let cellImagePath: String?
    let averageScore: Double
    let overview: String
    let genres: [String]
    let releaseDate: String
    let duration: Int
}
