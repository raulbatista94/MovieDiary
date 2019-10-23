//
//  MovieService.swift
//  MovieDiary
//
//  Created by Raul on 09/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Alamofire
import RxSwift
import Foundation

enum MovieServiceError: LocalizedError {
    case noDataReceived
    
    var errorDescription: String? {
        switch self {
        case .noDataReceived:
            return "No data received. Please check your internet connection."
        }
    }
}

final class MovieService {
    // If possible get rid of this not sure if is the best way to check current page of API
    private var moviePage: Int = 1
    private let jsonDecoder = JSONDecoder()
    
    /// Used to retrieve movie list from specified page by sending request to API.
    private func getPopularMovies() -> Observable<MovieList> {
        return Observable.create { emitter in
            request(Constants.baseApiUrlString + "popular",
                    method: .get,
                    parameters: ["api_key": Constants.apiKey,
                                 "page": self.moviePage])
                .responseJSON(completionHandler: { response in
                    if let error = response.error {
                        emitter.onError(error)
                    } else if let data = response.data,
                        let movieListDTO = try? self.jsonDecoder.decode(MovieListDTO.self, from: data) {
                        // Increase the page to load next page. FIXME: Maybe there is a better way to do this (ex. sending MovieList to MovieListController and work with the whole model instead of just the array of movies.)
                        self.moviePage = (movieListDTO.page ?? 0) + 1
                        return emitter.onNext(self.movieList(from: movieListDTO))
                    } else {
                        assertionFailure("Failed to parse data. Check if all the keys and data types are correctly set.")
                    }
                })
            return Disposables.create()
        }
    }
    
    
    /// Function used to retrieve YouTube video id. In case that we will use other parameters of the MovieDTO ensure that this function does not return just `String` type but the whole `MovieTrailer` to make available all the other attributes.
    /// - Parameter movie: Should be of type `Movie`. Please ensure that movie which is passed as argument to this function has valid id. Otherwise the function will fail.
    func getTrailerYoutTubeID(for movieId: Int) -> Single<String> {
        return Single.create { emitter in
            request(Constants.baseApiUrlString + String(movieId) + "/videos",
                    method: .get,
                    parameters: ["api_key": Constants.apiKey])
                .responseJSON(completionHandler: { response in
                    if let error = response.error {
                        emitter(.error(error))
                    } else if let data = response.data,
                        let movieTrailersContainerDTO = try? self.jsonDecoder.decode(MovieTrailersContainerDTO.self, from: data) {
                        emitter(.success(movieTrailersContainerDTO.results.first.map { self.movieTrailer(from: $0)}?.trailerYouTubeID ?? ""))
                    } else {
                        assertionFailure("Failed to parse data. Check if all the keys and data types are correctly set.")
                    }
                    
                })
            return Disposables.create()
        }
    }
    
    func getDetailForMovie(with id: Int) -> Single<MovieDetail> {
        return Single.create { emitter in
            request(Constants.baseApiUrlString + String(id),
                    method: .get,
                    parameters: ["api_key": Constants.apiKey])
                .responseJSON { response in
                    if let error = response.error {
                        emitter(.error(error))
                    } else if let data = response.data ,
                        let movieDetailDTO = try? self.jsonDecoder.decode(MovieDetailDTO.self, from: data) {
                        emitter(.success(self.movieDetail(from: movieDetailDTO)))
                    } else {
                        assertionFailure("Failed to parse data. Check if all the keys and types are correctly set.")
                    }
            }
            return Disposables.create()
        }
    }
    
    func observeMovies(previouslyLoadedMovies: [MovieCellItem]) -> Observable<[MovieCellItem]> {
        getPopularMovies()
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .flatMapLatest { movieListDTO -> Observable<[MovieCellItem]> in
                return .just(previouslyLoadedMovies + movieListDTO.movieResults)
        }
    }
    
    private func movieTrailer(from movieTrailerDTO: MovieTrailerDTO) -> MovieTrailer {
        return MovieTrailer(id: movieTrailerDTO.id, trailerYouTubeID: movieTrailerDTO.trailerYouTubeID, name: movieTrailerDTO.name, site: movieTrailerDTO.site, size: movieTrailerDTO.size)
    }
    
    private func movieDetail(from movieDetailDTO: MovieDetailDTO) -> MovieDetail {
        return MovieDetail(
            id: movieDetailDTO.id, title:
            movieDetailDTO.title,
            posterPath: movieDetailDTO.posterPath,
            cellImagePath: movieDetailDTO.cellImagePath,
            averageScore: movieDetailDTO.averageScore,
            overview: movieDetailDTO.overview,
            genres: movieDetailDTO.genres.map { $0.name },
            releaseDate: movieDetailDTO.releaseDate,
            duration: movieDetailDTO.duration ?? 0)
    }
    
    private func movieList(from movieListDTO: MovieListDTO) -> MovieList {
        return MovieList(page: movieListDTO.page ?? 0,
                         movieResults: movieListDTO.results.map { self.movie(from: $0) },
                         totalPages: movieListDTO.totalPages ?? 0)
    }
    
    
    private func movie(from movieDTO: MovieCellDTO) -> MovieCellItem {
        return MovieCellItem(
            id: movieDTO.id,
            title: movieDTO.title,
            posterPath: movieDTO.posterPath,
            cellImagePath: movieDTO.cellImagePath ?? movieDTO.posterPath, // This is intentional to avoid empty cell images.
            averageScore: movieDTO.averageScore)
    }
}
