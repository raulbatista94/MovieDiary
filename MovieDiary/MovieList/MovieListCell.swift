//
//  MovieListCell.swift
//  MovieDiary
//
//  Created by Raul Batista on 12/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MovieListCell: UITableViewCell {
    let movieTitle = UILabel()
    let movieImage = UIImageView()
    let averageScoreLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cell")
        activityIndicator.startAnimating()
        addSubViews()
        setupViewConstraints()
        styleView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubViews() {
        addSubview(activityIndicator)
        addSubview(movieImage)
        addSubview(movieTitle)
        addSubview(averageScoreLabel)
    }

    func styleView() {
        movieTitle.textColor = .white
        movieTitle.font = UIFont.boldSystemFont(ofSize: 30)
        movieImage.contentMode = .scaleAspectFill
        movieImage.layer.cornerRadius = 8
        movieImage.clipsToBounds = true
        activityIndicator.style = .gray
    }

    func setupViewConstraints() {
        movieImage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(16)
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        movieTitle.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
        }
    }
}
