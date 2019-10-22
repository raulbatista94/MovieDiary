//
//  MovieDetailView.swift
//  MovieDiary
//
//  Created by Raul on 16/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit

final class MovieDetailView: BaseView {
    let movieImagePoster = UIImageView()
    let movieDescriptionLabel = UILabel()
    let movieTitleLabel = UILabel()
    let playButton = UIButton()
    let genresTitleLabel = UILabel()
    let scrollView = UIScrollView()
    let genresLabel = UILabel()
    let contentView = UIView()
    
    
    override func prepareSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieImagePoster)
        contentView.addSubview(genresTitleLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(movieDescriptionLabel)
        contentView.addSubview(playButton)
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
        
        contentView.backgroundColor = .black
        
        genresTitleLabel.text = "Genres:"
        genresTitleLabel.textColor = .white
        genresTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        genresLabel.textColor = .white
        genresLabel.numberOfLines = 0
        
        playButton.setTitle("Watch Trailer", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.layer.cornerRadius = 4
        playButton.clipsToBounds = true
        playButton.backgroundColor = UIColor().fromRGB(rgb: 0xa31c37)
    }
    
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
                make.width.equalTo(UIScreen.main.bounds.width / 3)
                // 1.5 is the aspect ratio of the image
                ///ex: 780 × 1170 are the dismensions of our image.
                /// To get the correct aspect ratio we divide the height of the original image by the width of the original image and we get 1.5
                /// Since we have fixed width of the image we just multiply it by 1.5 to set the correct height to not deform the image.
                make.height.equalTo((UIScreen.main.bounds.width / 3) * 1.5)
            }
            
            
            playButton.snp.remakeConstraints { make in
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
                make.trailing.equalToSuperview().inset(16)
                make.bottom.equalTo(movieImagePoster.snp.bottom)
            }
            
            genresTitleLabel.snp.remakeConstraints { make in
                make.top.equalTo(movieImagePoster.snp.bottom).offset(15)
                make.leading.equalToSuperview().inset(16)
            }
            
            genresLabel.snp.remakeConstraints { make in
                make.top.equalTo(genresTitleLabel.snp.bottom).offset(4)
                make.leading.equalTo(genresTitleLabel)
                make.trailing.lessThanOrEqualToSuperview().inset(16)
            }
            
            movieDescriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            movieDescriptionLabel.snp.remakeConstraints { make in
                make.top.equalTo(genresLabel.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().inset(14)
            }
        } else if UIDevice.current.orientation.isPortrait {
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
                make.top.equalToSuperview()
                make.trailing.equalToSuperview().inset(16)
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
            }
            
            genresTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            genresTitleLabel.snp.remakeConstraints { make in
                make.top.equalTo(movieTitleLabel.snp.bottom).offset(15)
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
            }
            
            genresLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            genresLabel.snp.remakeConstraints { make in
                make.top.equalTo(genresTitleLabel.snp.bottom).offset(4)
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
                make.trailing.equalToSuperview().inset(16)
                make.bottom.lessThanOrEqualTo(movieImagePoster.snp.bottom)
                
            }
            
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
        if UIDevice.current.orientation.isLandscape || UIDevice.current.orientation.isFlat {
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
                make.width.equalTo(UIScreen.main.bounds.height / 3)
                make.height.equalTo((UIScreen.main.bounds.height / 3) * 1.5)
            }
            
            
            playButton.snp.makeConstraints { make in
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
                make.trailing.equalToSuperview().inset(16)
                make.bottom.equalTo(movieImagePoster.snp.bottom)
            }
            
            genresTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            genresTitleLabel.snp.makeConstraints { make in
                make.top.equalTo(movieImagePoster.snp.bottom).offset(15)
                make.leading.equalToSuperview().inset(16)
            }
            
            genresLabel.snp.makeConstraints { make in
                make.top.equalTo(genresTitleLabel.snp.bottom).offset(4)
                make.leading.equalTo(genresTitleLabel)
                make.trailing.lessThanOrEqualToSuperview().inset(16)
            }
            
            movieDescriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            movieDescriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(genresLabel.snp.bottom).offset(20)
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
            
            genresTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            genresTitleLabel.snp.makeConstraints { make in
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
                make.top.equalTo(movieTitleLabel.snp.bottom).offset(15)
            }
            
            genresLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            genresLabel.snp.makeConstraints { make in
                make.top.equalTo(genresTitleLabel.snp.bottom).offset(4)
                make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
                make.trailing.equalToSuperview().inset(16)
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
