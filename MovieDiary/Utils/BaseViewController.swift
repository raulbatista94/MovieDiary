//
//  BaseViewController.swift
//  MovieDiary
//
//  Created by Raul Batista on 10/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit
import RxSwift

open class BaseViewController: UIViewController {
    public let disposeBag = DisposeBag()

    override open func viewDidLoad() {
        super.viewDidLoad()
    }


    public init(contentView: UIView) {
        super.init(nibName: nil, bundle: nil)
        self.view = contentView
    }

    public init(contentView: UIView, title: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.view = contentView
        self.title = title
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
