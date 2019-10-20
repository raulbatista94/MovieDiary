//
//  MovieListViewModel.swift
//  MovieDiary
//
//  Created by Raul Batista on 12/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieListViewModel {
    struct DataSource {
        let movieList = BehaviorRelay<[Movie]>(value: [])
    }

    /// This variable is used for search and filtering since we are filtering only from already loaded movies.
    var loadedMovies: [Movie] = []
    let dataSource: DataSource
    let dependencies: MovieListDependencies

    private let disposeBag = DisposeBag()

    init(dependencies: MovieListDependencies) {
        self.dataSource = DataSource()
        self.dependencies = dependencies

    }

    func loadMovies() {
        dependencies.movieService.observeMovies(previouslyLoadedMovies: dataSource.movieList.value)
            .retry(3)
            .subscribe(onNext: { [weak self] movieList in
                self?.loadedMovies = movieList
                self?.dataSource.movieList.accept(self?.loadedMovies ?? [])
            }, onError: { error in
                errorIndicator.onNext(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
