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
    // If possible get rid of this
    private var moviePage: Int = 1
        
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
                        let movieListDTO = try? JSONDecoder().decode(MovieListDTO.self, from: data) {
                        // Increase the page to load next page
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
    func getTrailerYoutTubeID(for movie: Movie) -> Single<String> {
        return Single.create { emitter in
            request(Constants.baseApiUrlString + "\(movie.id)" + "/videos",
                    method: .get,
                    parameters: ["api_key": Constants.apiKey])
                .responseJSON(completionHandler: { response in
                    if let error = response.error {
                        emitter(.error(error))
                    } else if let data = response.data,
                        let movieTrailersContainerDTO = try? JSONDecoder().decode(MovieTrailersContainerDTO.self, from: data) {
                        emitter(.success(movieTrailersContainerDTO.results.first.map { self.movieTrailer(from: $0)}?.trailerYouTubeID ?? ""))
                    } else {
                        assertionFailure("Failed to parse data. Check if all the keys and data types are correctly set.")
                    }
                    
                })
            return Disposables.create()
        }
    }
    
    func getGenres() {
        request(Constants.genresUrl,
                method: .get,
                parameters: ["api_key": Constants.apiKey])
            .responseJSON { response in
                if let error = response.error {
                    errorIndicator.onNext(error.localizedDescription)
                } else if let data = response.data,
                    let genresContainer = try? JSONDecoder().decode(MovieGenresContainer.self, from: data) {
                    Constants.genres = genresContainer.genres.map { self.genre(from: $0) }
                } else {
                    assertionFailure("Failed to parse data. Check if all the keys and data types are correctly set.")
                }
        }
    }
    
    func observeMovies(previouslyLoadedMovies: [Movie]) -> Observable<[Movie]> {
        getPopularMovies()
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .flatMapLatest { movieListDTO -> Observable<[Movie]> in
                return .just(previouslyLoadedMovies + movieListDTO.movieResults)
        }
    }
    
    private func movieTrailer(from movieTrailerDTO: MovieTrailerDTO) -> MovieTrailer {
        return MovieTrailer(id: movieTrailerDTO.id, trailerYouTubeID: movieTrailerDTO.trailerYouTubeID, name: movieTrailerDTO.name, site: movieTrailerDTO.site, size: movieTrailerDTO.size)
    }
    
    private func movieList(from movieListDTO: MovieListDTO) -> MovieList {
        return MovieList(page: movieListDTO.page ?? 0,
                         movieResults: movieListDTO.results.map { self.movie(from: $0) },
                         totalPages: movieListDTO.totalPages ?? 0)
    }
    
    private func genre(from genreDTO: MovieGenreDTO) -> MovieGenre {
        return MovieGenre(id: genreDTO.id, name: genreDTO.name)
    }
    
    private func getGenre(by id: Int) -> String {
        return Constants.genres.first { $0.id == id }?.name ?? ""
    }
    
    private func movie(from movieDTO: MovieDTO) -> Movie {
        return Movie(
            id: movieDTO.id,
            title: movieDTO.title,
            posterPath: movieDTO.posterPath,
            cellImagePath: movieDTO.cellImagePath ?? movieDTO.posterPath, // This is intentional to avoid empty cell images.
            averageScore: movieDTO.averageScore,
            overview: movieDTO.overview,
            genres: movieDTO.genreIds.map { self.getGenre(by: $0) })
    }
}
