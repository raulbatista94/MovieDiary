//
//  MovieDetailViewModel.swift
//  MovieDiary
//
//  Created by Raul on 16/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieDetailViewModel {
    struct DataSource {
        let movie = BehaviorRelay<Movie?>(value: nil)
    }
    
    let dataSource: DataSource
    private let movie: Movie
    
    init(movie: Movie) {
        self.dataSource = DataSource()
        self.movie = movie
        setup()
    }
    
    private func setup() {
        dataSource.movie.accept(movie)
    }
}
