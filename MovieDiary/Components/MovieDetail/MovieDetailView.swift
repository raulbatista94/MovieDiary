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
    
    override func prepareSubviews() {
        addSubview(movieTitleLabel)
        addSubview(movieImagePoster)
        addSubview(movieDescriptionLabel)
    }
    
    override func styleViews() {
        movieImagePoster.contentMode = .scaleAspectFit
        movieDescriptionLabel.textColor = .white
        movieDescriptionLabel.numberOfLines = 0
    }
    
    override func setupViewConstraints() {
        movieImagePoster.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.top.equalTo(safeAreaLayoutGuide).inset(10)
            } else {
                make.top.equalToSuperview().inset(30)
            }
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(UIScreen.main.bounds.width / 3)
            // 1.5 is the aspect ratio of the image
            ///ex: 780 × 1170 are the dismensions of our image.
            /// To get the correct aspect ratio we divide the height of the original image by the width of the original image and we get 1.5
            /// Since we have fixed width of the image we just multiply it by 1.5 to set the correct height to not deform the image.
            make.height.equalTo((UIScreen.main.bounds.width / 3) * 1.5)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.top.equalTo(safeAreaLayoutGuide).inset(10)
            } else {
                make.top.equalToSuperview().inset(30)
            }
            make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        movieDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(15)
            make.leading.equalTo(movieImagePoster.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}
