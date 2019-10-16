//
//  ActivityIndicator.swift
//  MovieDiary
//
//  Created by Raul on 17/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation
import JGProgressHUD
import RxSwift

public let errorIndicator = AnyObserver<String> { event in
    switch event {
    case .next(let value):
        guard let window = UIApplication.shared.keyWindow else { return }
        let hud = JGProgressHUD(style: .extraLight)
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.textLabel.text = value
        hud.backgroundColor = UIColor(white: 0, alpha: 0.7)
        hud.show(in: window)
        hud.dismiss(afterDelay: 5)
        hud.tapOutsideBlock = { hud in
            hud.dismiss()
        }

    default:
        return
    }
}
