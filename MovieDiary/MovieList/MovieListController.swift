//
//  MovieListController.swift
//  MovieDiary
//
//  Created by Raul Batista on 10/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Kingfisher

class MovieListController: UITableViewController {

//    private let initialView = MovieListView()
    private let movieListViewModel: MovieListViewModel
    private let disposeBag = DisposeBag()
    private let router: Router

    init(movieListViewModel: MovieListViewModel, router: Router) {
        self.movieListViewModel = movieListViewModel
        self.router = router
        super.init(style: .plain)
        view = tableView
        movieListViewModel.loadMovies()
        tableView.register(MovieListCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        bind()
    }

    func bind() {
        movieListViewModel.dataSource.movieList
            .subscribe(onNext: { [weak self] data in
                print(data)
                self?.tableView.reloadData()
        })
            .disposed(by: disposeBag)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewModel.dataSource.movieList.value.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    tableViewdids

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieListCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieListCell
        cell.movieTitle.text = self.movieListViewModel.dataSource.movieList.value[indexPath.row].title
        let imageUrl = "https://image.tmdb.org/t/p/w342" + self.movieListViewModel.dataSource.movieList.value[indexPath.row].posterPath

        cell.movieImage.kf.setImage(with: URL(string: imageUrl), placeholder: nil)
        return cell
    }
}
