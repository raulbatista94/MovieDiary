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
import RxSwift

final class MovieDetailController: BaseViewController<MovieDetailView> {
    private let movieDetailViewModel: MovieDetailViewModel
    private let router: Router
    private let playerViewController = AVPlayerViewController()
    
    init(movieDetailViewModel: MovieDetailViewModel, router: Router) {
        self.movieDetailViewModel = movieDetailViewModel
        self.router = router
    
        super.init(title: movieDetailViewModel.dataSource.movie.value?.title)
        contentView.activityIndicator.startAnimating()
        bind()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
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
                self.contentView.genresLabel.text = movie.genres.joined(separator: ", ")
                self.contentView.activityIndicator.stopAnimating()
                self.contentView.loadingView.isHidden = true
                
            }).disposed(by: disposeBag)
        
        contentView.playButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.playVideo()
            })
        .disposed(by: disposeBag)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        contentView.adjustViewConstraints()
    }
    
    private func playVideo() {
        guard let movieTrailerID = movieDetailViewModel.dataSource.movieTrailerID.value else {
            errorIndicator.onNext("Coul'd not find any trailers for this movie.")
            return
        }
        self.present(playerViewController, animated: true, completion: nil)

        XCDYouTubeClient.default().getVideoWithIdentifier(movieTrailerID) { (video: XCDYouTubeVideo?, error: Error?) in
            if let error = error {
                errorIndicator.onNext(error.localizedDescription)
                self.dismiss(animated: true, completion: nil)
            } else if let streamURL = video?.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] {
                self.playerViewController.player = AVPlayer(url: streamURL)
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(self.playerDidFinishPlaying),
                    name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                    object: self.playerViewController.player?.currentItem)
                self.playerViewController.player?.play()
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.playerViewController.dismiss(animated: true, completion: nil)
    }
}
