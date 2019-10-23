//
//  MovieDetailView.swift
//  MovieDiary
//
//  Created by Raul on 16/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit

final class MovieDetailView: BaseView {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let loadingView = UIView()
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    let movieImagePoster = UIImageView()
    let movieDescriptionLabel = UILabel()
    let movieTitleLabel = UILabel()
    let playButton = UIButton()
    let genresLabel = UILabel()
    let durationLabel = UILabel()
    let averageScoreLabel = UILabel()
    let releaseDateLabel = UILabel()
    
    override func prepareSubviews() {
        addSubview(scrollView)
        addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        scrollView.addSubview(contentView)
        // If more parts of contentView are added don't forget to add them to this array aswell. Please consider that the order affects the view hierarchy.
        let contentSubviews = [movieTitleLabel, movieImagePoster, genresLabel, movieDescriptionLabel, durationLabel, averageScoreLabel, releaseDateLabel, playButton]
        contentSubviews.forEach { contentView.addSubview($0) }
    }
    
    override func styleViews() {
        movieImagePoster.contentMode = .scaleAspectFit
        movieDescriptionLabel.textColor = .white
        movieDescriptionLabel.numberOfLines = 0
        
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 44)
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.textColor = .white
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.adjustsFontSizeToFitWidth = true
        
        loadingView.backgroundColor = UIColor().fromRGB(rgb: 0x666666, alpha: 0.5)
        loadingView.layer.cornerRadius = 10
        loadingView.clipsToBounds = true
        
        activityIndicator.hidesWhenStopped = true
        
        contentView.backgroundColor = .black
        genresLabel.numberOfLines = 0
        averageScoreLabel.numberOfLines = 0
        releaseDateLabel.numberOfLines = 0
        
        playButton.setTitle("Watch Trailer", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.layer.cornerRadius = 4
        playButton.clipsToBounds = true
        playButton.backgroundColor = UIColor().fromRGB(rgb: 0xa31c37, alpha: 1)
    }
    
    /// Function used to adjust constraint when device orientation changes.
    func adjustViewConstraints() {
        if UIDevice.current.orientation.isLandscape {
            scrollView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            contentView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalToSuperview()
            }
            
            movieTitleLabel.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.trailing.equalToSuperview().inset(16)
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
            }
            
            movieImagePoster.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.leading.equalToSuperview().inset(16)
                make.width.equalTo(UIScreen.main.bounds.height / 4)
                // 1.5 is the aspect ratio of the image
                //ex: 780 × 1170 are the dismensions of our image.
                // To get the correct aspect ratio we divide the height of the original image by the width of the original image and we get 1.5
                // Since we have fixed width of the image we just multiply it by 1.5 to set the correct height to not deform the image.
                make.height.equalTo((UIScreen.main.bounds.height / 4) * 1.5)
            }
            
            
            playButton.snp.remakeConstraints { make in
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
                make.trailing.equalToSuperview().inset(16)
                make.top.equalTo(releaseDateLabel.snp.bottom).offset(6)
                make.bottom.equalTo(movieImagePoster.snp.bottom)
            }
                        
            
            genresLabel.snp.remakeConstraints { make in
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
                make.top.greaterThanOrEqualTo(movieTitleLabel.snp.bottom).offset(15)
                make.trailing.lessThanOrEqualToSuperview().inset(16)
            }
            
            averageScoreLabel.snp.remakeConstraints { make in
                make.leading.equalTo(genresLabel.snp.leading)
                make.top.equalTo(genresLabel.snp.bottom).offset(6)
                make.trailing.equalToSuperview().inset(16)
            }
            
            durationLabel.snp.remakeConstraints { make in
                make.top.equalTo(averageScoreLabel.snp.bottom).offset(6)
                make.leading.equalTo(genresLabel.snp.leading)
                make.trailing.equalToSuperview().inset(16)
            }
            
            releaseDateLabel.snp.remakeConstraints { make in
                make.top.equalTo(durationLabel.snp.bottom).offset(6)
                make.leading.equalTo(genresLabel.snp.leading)
                make.trailing.equalToSuperview().inset(16)
            }
            
            movieDescriptionLabel.snp.remakeConstraints { make in
                make.top.equalTo(playButton.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().inset(14)
            }
        } else if UIDevice.current.orientation.isPortrait || UIDevice.current.orientation.isFlat {
            scrollView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            contentView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalToSuperview()
            }
            movieImagePoster.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.leading.equalToSuperview().inset(16)
                make.width.equalTo(UIScreen.main.bounds.height / 3)
                make.height.equalTo((UIScreen.main.bounds.height / 3) * 1.5)
            }
            
            movieTitleLabel.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.trailing.equalToSuperview().inset(16)
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
            }
            
            genresLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            genresLabel.snp.remakeConstraints { make in
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
                make.top.equalTo(movieTitleLabel.snp.bottom).offset(15)
                make.trailing.lessThanOrEqualToSuperview().inset(16)
            }
            
            averageScoreLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            averageScoreLabel.snp.remakeConstraints { make in
                make.top.equalTo(genresLabel.snp.bottom).offset(6)
                make.leading.equalTo(genresLabel.snp.leading)
                make.trailing.lessThanOrEqualToSuperview().inset(16)
            }
            
            durationLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            durationLabel.snp.remakeConstraints { make in
                make.top.equalTo(averageScoreLabel.snp.bottom).offset(6)
                make.leading.equalTo(genresLabel.snp.leading)
                make.trailing.lessThanOrEqualToSuperview().inset(16)
            }
            
            releaseDateLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            releaseDateLabel.snp.remakeConstraints { make in
                make.top.equalTo(durationLabel.snp.bottom).offset(6)
                make.leading.equalTo(genresLabel.snp.leading)
                make.trailing.lessThanOrEqualToSuperview().inset(16)
                make.bottom.lessThanOrEqualTo(movieImagePoster.snp.bottom)
            }
                        
            movieDescriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            movieDescriptionLabel.snp.remakeConstraints { make in
                make.top.equalTo(movieImagePoster.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(16)
            }
            
            playButton.snp.remakeConstraints { make in
                make.top.equalTo(movieDescriptionLabel.snp.bottom).offset(18)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(50)
                make.bottom.lessThanOrEqualToSuperview()
            }
        }
    }
    
    override func setupViewConstraints() {
        loadingView.snp.makeConstraints  { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        if UIDevice.current.orientation.isLandscape {
            scrollView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            contentView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalToSuperview()
            }
            
            movieTitleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.trailing.equalToSuperview().inset(16)
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
            }
            
            movieImagePoster.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.leading.equalToSuperview().inset(16)
                make.width.equalTo(UIScreen.main.bounds.width / 4)
                make.height.equalTo((UIScreen.main.bounds.width / 4) * 1.5)
            }
            
            
            playButton.snp.makeConstraints { make in
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
                make.trailing.equalToSuperview().inset(16)
                make.top.equalTo(releaseDateLabel.snp.bottom).offset(6)
                make.bottom.equalTo(movieImagePoster.snp.bottom)
            }
                        
            
            genresLabel.snp.makeConstraints { make in
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
                make.top.greaterThanOrEqualTo(movieTitleLabel.snp.bottom).offset(15)
                make.trailing.lessThanOrEqualToSuperview().inset(16)
            }
            
            averageScoreLabel.snp.makeConstraints { make in
                make.leading.equalTo(genresLabel.snp.leading)
                make.top.equalTo(genresLabel.snp.bottom).offset(6)
                make.trailing.equalToSuperview().inset(16)
            }
            
            durationLabel.snp.makeConstraints { make in
                make.top.equalTo(averageScoreLabel.snp.bottom).offset(6)
                make.leading.equalTo(genresLabel.snp.leading)
                make.trailing.equalToSuperview().inset(16)
            }
            
            releaseDateLabel.snp.makeConstraints { make in
                make.top.equalTo(durationLabel.snp.bottom).offset(6)
                make.leading.equalTo(genresLabel.snp.leading)
                make.trailing.equalToSuperview().inset(16)
            }
            
            movieDescriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(playButton.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().inset(14)
            }
        } else {
            scrollView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            contentView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalToSuperview()
            }
            
            movieImagePoster.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.leading.equalToSuperview().inset(16)
                make.width.equalTo(UIScreen.main.bounds.width / 3)
                make.height.equalTo((UIScreen.main.bounds.width / 3) * 1.5)
            }
            
            movieTitleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.trailing.equalToSuperview().inset(16)
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
            }
            
            genresLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            genresLabel.snp.makeConstraints { make in
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
                make.top.equalTo(movieTitleLabel.snp.bottom).offset(15)
                make.trailing.lessThanOrEqualToSuperview().inset(16)
            }
            
            averageScoreLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            averageScoreLabel.snp.makeConstraints { make in
                make.top.equalTo(genresLabel.snp.bottom).offset(6)
                make.leading.equalTo(genresLabel.snp.leading)
                make.trailing.lessThanOrEqualToSuperview().inset(16)
            }
            
            durationLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            durationLabel.snp.makeConstraints { make in
                make.top.equalTo(averageScoreLabel.snp.bottom).offset(6)
                make.leading.equalTo(genresLabel.snp.leading)
                make.trailing.lessThanOrEqualToSuperview().inset(16)
            }
            
            releaseDateLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            releaseDateLabel.snp.makeConstraints { make in
                make.top.equalTo(durationLabel.snp.bottom).offset(6)
                make.leading.equalTo(genresLabel.snp.leading)
                make.trailing.lessThanOrEqualToSuperview().inset(16)
                make.bottom.lessThanOrEqualTo(movieImagePoster.snp.bottom)
            }
                        
            movieDescriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            movieDescriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(movieImagePoster.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(16)
            }
            
            playButton.snp.makeConstraints { make in
                make.top.equalTo(movieDescriptionLabel.snp.bottom).offset(18)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(50)
                make.bottom.lessThanOrEqualToSuperview()
            }
        }
    }
}
