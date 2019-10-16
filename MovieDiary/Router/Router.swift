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
        let movieDetailViewModel = MovieDetailViewModel(movie: movie)
        let movieDetailController = MovieDetailController(movieDetailViewModel: movieDetailViewModel, router: self)
        controller.pushViewController(movieDetailController, animated: false)
    }
    
    func showErrorAlert(from controller: UINavigationController) {
        let alertDialog = UIAlertController(title: "Error", message: "Failed to perform your request. Please check your internet connection and try again.", preferredStyle: .alert)
        alertDialog.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        controller.present(alertDialog, animated: true, completion: nil)
    }
}
