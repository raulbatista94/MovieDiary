//
//  Router.swift
//  MovieDiary
//
//  Created by Raul on 09/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit

class Router {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    private func setupViews() {
        #warning("This is just default UIViewController. Replace this with the first controller in App hierarchy.")
        window.rootViewController = UIViewController()
    }
    
//    /// Use this function to move to the detail controller for specific movie.
//    /// - Parameter movie: Single object of type `Movie`.
//    func showMovieDetail(movie: Movie) {
//
//    }
}
