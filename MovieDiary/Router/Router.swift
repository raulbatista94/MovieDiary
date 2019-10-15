//
//  Router.swift
//  MovieDiary
//
//  Created by Raul on 09/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit
import Foundation

class Router {
    private let window: UIWindow
    private let dependencies: Dependencies
    
    init(window: UIWindow, dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies

        entryPoint()
    }
    
    private func entryPoint() {
        let model = MovieListViewModel(dependencies: dependencies)
        let controller = UINavigationController(rootViewController: MovieListController(movieListViewModel: model, router: self))
        window.rootViewController = controller
    }
    
    func movieDetail(movie: Movie, from controller: UINavigationController) {
        let movieDetailController = UIViewController()
        controller.pushViewController(movieDetailController, animated: true)
    }
}
