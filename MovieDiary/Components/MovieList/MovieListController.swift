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

    private let movieListViewModel: MovieListViewModel
    private let disposeBag = DisposeBag()
    private let router: Router
    private let searchBar = UISearchBar(frame: .zero)
    private var isSearchActive: Bool = false
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    init(movieListViewModel: MovieListViewModel, router: Router) {
        self.movieListViewModel = movieListViewModel
        self.router = router
        super.init(style: .plain)
        view = tableView
        activityIndicator.startAnimating()
        movieListViewModel.loadMovies()
        tableView.register(MovieListCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        bind()
    }
    
    func bind() {
        movieListViewModel.dataSource.movieList
            .retry()
            .subscribe(
                onNext: { [weak self] data in
                    self?.tableView.reloadData()
                },
                onError: { _ in
                    self.router.showErrorAlert(from: self.navigationController!)
                })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(activityIndicator)
        searchBar.tintColor = .darkGray
        searchBar.placeholder = "Type movie title... "
        searchBar.barTintColor = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) && !isSearchActive {
            let lastIndexPath = IndexPath(row: movieListViewModel.loadedMovies.count - 1, section: 0)
            movieListViewModel.loadMovies()
            bind()
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) { [weak self] in
                self?.tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: false)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movieListViewModel.dataSource.movieList.value[indexPath.row]
        self.router.movieDetail(movie: selectedMovie, from: self.navigationController!)
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
    
    override func loadView() {
        super.loadView()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        navigationItem.titleView = searchBar
        
        searchBar.rx.text.asObservable()
            .flatMapLatest { [weak self] queryText -> Observable<Void> in
                if queryText != "" {
                    self?.isSearchActive = true
                    self?.movieListViewModel.dataSource.movieList.accept(self?.movieListViewModel.loadedMovies.filter { $0.title.localizedCaseInsensitiveContains(queryText!) } ?? [])
                } else {
                    self?.isSearchActive = false
                    self?.movieListViewModel.dataSource.movieList.accept(self?.movieListViewModel.loadedMovies ?? [])
                }
                return .just(())
        }
        .subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieListCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieListCell
        cell.movieTitle.text = self.movieListViewModel.dataSource.movieList.value[indexPath.row].title
        cell.averageScoreLabel.text = String(self.movieListViewModel.dataSource.movieList.value[indexPath.row].averageScore)
        let imageUrl = Constants.baseImagesUrlString + self.movieListViewModel.dataSource.movieList.value[indexPath.row].cellImagePath

        cell.movieImage.kf.setImage(with: URL(string: imageUrl), placeholder: nil)
        activityIndicator.stopAnimating()
        return cell
    }
}
