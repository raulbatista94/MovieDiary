//
//  BaseView.swift
//  MovieDiary
//
//  Created by Raul Batista on 10/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit
import RxSwift

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
        styleViews()
        setupViewConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareSubviews()
        setupViewConstraints()
    }

    func prepareSubviews() { }
    func styleViews() { }
    func setupViewConstraints() {}

}
