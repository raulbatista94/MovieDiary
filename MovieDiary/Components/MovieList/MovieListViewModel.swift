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

protocol MovieListDependencies {
    var movieService: MovieService { get }
}

extension Dependencies: MovieListDependencies { }

final class MovieListViewModel {
    struct DataSource {
        let movieList = BehaviorRelay<[Movie]>(value: [])
    }

    /// This variable is used for search and filtering
    var loadedMovies: [Movie] = []
    let dataSource: DataSource
    let dependencies: MovieListDependencies

    private let disposeBag = DisposeBag()

    init(dependencies: MovieListDependencies) {
        self.dataSource = DataSource()
        self.dependencies = dependencies

    }

    func loadMovies(searchQuery: String) {
        dependencies.movieService.observeMovies(previouslyLoadedMovies: dataSource.movieList.value, searchQuery: searchQuery)
            .subscribe(onNext: { [weak self] movieList in
                self?.loadedMovies = movieList
                self?.dataSource.movieList.accept(self?.loadedMovies ?? [])
            }, onError: { error in
                assertionFailure("FAILED \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
