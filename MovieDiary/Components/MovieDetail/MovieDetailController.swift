//
//  MovieDetailController.swift
//  MovieDiary
//
//  Created by Raul on 16/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit
import AVKit
import XCDYouTubeKit

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
        contentView.playButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.playVideo()
            })
        .disposed(by: disposeBag)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func playVideo() {

        let playerViewController = AVPlayerViewController()
        self.present(playerViewController, animated: true, completion: nil)

        XCDYouTubeClient.default().getVideoWithIdentifier("t433PEQGErc") { (video: XCDYouTubeVideo?, error: Error?) in
            if let error = error {
                errorIndicator.onNext(error.localizedDescription)
            } else if let streamURL = video?.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] {
                playerViewController.player = AVPlayer(url: streamURL)
                NotificationCenter.default.addObserver(self, selector: Selector(("dismissController:")),
                                                       name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerViewController.player?.currentItem)
                playerViewController.player?.play()
                
            } else {
                dismissController()
            }
        }
        
        func dismissController() {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
