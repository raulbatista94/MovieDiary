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
        let movie = BehaviorRelay<MovieDetail?>(value: nil)
        let movieTrailerID = BehaviorRelay<String?>(value: nil)
    }
    
    let dataSource: DataSource
    private let movieId: Int
    private let disposeBag = DisposeBag()
    private let movieListDependencies: MovieListDependencies
    
    init(movieListDependencies: MovieListDependencies, movieId: Int) {
        self.dataSource = DataSource()
        self.movieId = movieId
        self.movieListDependencies = movieListDependencies
        
        setup()
    }
    
    private func setup() {
        movieListDependencies.movieService.getDetailForMovie(with: movieId)
        .flatMap { [weak self] movieDetail -> Single<(movieDetail: MovieDetail, trailerID: String)> in
            guard let self = self else { return .never() }
            return self.movieListDependencies.movieService.getTrailerYoutTubeID(for: self.movieId)
                .map { trailerID -> (movieDetail: MovieDetail, trailerID: String) in
                    return (movieDetail, trailerID)
                }
        }
        .subscribe(onSuccess: { [weak self] movieDetail, trailerId in
            guard let self = self else { return }
            self.dataSource.movie.accept(movieDetail)
            self.dataSource.movieTrailerID.accept(trailerId)
            
        }).disposed(by: disposeBag)
    }
}
