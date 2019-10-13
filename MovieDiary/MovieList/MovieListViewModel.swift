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

    /// This variable will be used for pagination. Every new result will be apended to this
    private var loadedMovies: [Movie] = []
    let dataSource: DataSource
    let dependencies: MovieListDependencies

    private let disposeBag = DisposeBag()

    init(dependencies: MovieListDependencies) {
        self.dataSource = DataSource()
        self.dependencies = dependencies

    }

    func loadMovies() {
        dependencies.movieService.getPopularMovies()
            .subscribe(onNext: { [weak self] movieList in
                movieList.movieResults.forEach { self?.loadedMovies.append($0) }
                self?.dataSource.movieList.accept(self?.loadedMovies ?? [])
            }, onError: { error in
                assertionFailure("FAILED \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}