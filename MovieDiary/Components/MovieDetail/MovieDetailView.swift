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
    
    override func prepareSubviews() {
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
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(300)
        }
        
        movieDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImagePoster.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.lessThanOrEqualToSuperview().inset(15)
        }
    }
}
