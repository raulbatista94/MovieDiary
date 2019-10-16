//
//  BaseViewController.swift
//  MovieDiary
//
//  Created by Raul Batista on 10/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit
import RxSwift

open class BaseViewController<VIEW: UIView>: UIViewController {
    public let disposeBag = DisposeBag()
    public let contentView: VIEW
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public init() {
        contentView = VIEW()
        super.init(nibName: nil, bundle: nil)
        view = contentView
    }
    
    public init(title: String? = nil) {
        contentView = VIEW()
        super.init(nibName: nil, bundle: nil)
        view = contentView
        navigationItem.title = title
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        contentView = VIEW()
        super.init(coder: aDecoder)
        view = contentView
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
