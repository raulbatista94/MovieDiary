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
        let movieTrailerID = BehaviorRelay<String?>(value: nil)
    }
    
    let dataSource: DataSource
    private let movie: Movie
    private let disposeBag = DisposeBag()
    private let movieListDependencies: MovieListDependencies
    
    init(movieListDependencies: MovieListDependencies, movie: Movie) {
        self.dataSource = DataSource()
        self.movie = movie
        self.movieListDependencies = movieListDependencies
        
        setup()
    }
    
    private func setup() {
        dataSource.movie.accept(movie)
        movieListDependencies.movieService.getTrailerYoutTubeID(for: movie)
            .subscribe(onSuccess: { [weak self] movieID in
                self?.dataSource.movieTrailerID.accept(movieID)
            }, onError: { error in
                errorIndicator.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
