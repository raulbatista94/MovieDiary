//
//  MovieDetailController.swift
//  MovieDiary
//
//  Created by Raul on 16/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit

final class MovieDetailController: BaseViewController<MovieDetailView> {
    private let movieDetailViewModel: MovieDetailViewModel
    private let router: Router
    
    init(movieDetailViewModel: MovieDetailViewModel, router: Router) {
        self.movieDetailViewModel = movieDetailViewModel
        self.router = router
    
        super.init(title: movieDetailViewModel.dataSource.movie.value?.title)
        bind()
    }
    
    private func bind() {
        movieDetailViewModel.dataSource.movie
            .subscribe(onNext: { [weak self] movie in
                guard let self = self,
                    let movie = movie else { return }
                let imageUrl = Constants.baseImagesUrlString + movie.posterPath
                self.contentView.movieImagePoster.kf.setImage(with: URL(string: imageUrl))
                self.contentView.movieDescriptionLabel.text = movie.overview
                self.contentView.movieTitleLabel.text = movie.title
                
            }).disposed(by: disposeBag)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}
