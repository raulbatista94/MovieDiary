//
//  Dependencies.swift
//  MovieDiary
//
//  Created by Raul Batista on 12/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation

class Dependencies: MovieListDependencies {
    lazy var movieService: MovieService = {
        return MovieService()
    }()
}

/// Used to provide only the necessary dependencies to ViewModels.
protocol MovieListDependencies {
    var movieService: MovieService { get }
}
