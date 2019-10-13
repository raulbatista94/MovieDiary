//
//  Dependencies.swift
//  MovieDiary
//
//  Created by Raul Batista on 12/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation

class Dependencies {
    lazy var movieService: MovieService = {
        return MovieService()
    }()
}
