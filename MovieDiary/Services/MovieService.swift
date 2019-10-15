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
    private let constants = Constants()
    func getPopularMovies() -> Observable<MovieList> {
        return Observable.create { emitter in
            request(self.constants.baseApiUrlString,
                    method: .get,
                    parameters: ["api_key": self.constants.apiKey,
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
    
    private func movieList(from movieListDTO: MovieListDTO) -> MovieList {
        return MovieList(page: movieListDTO.page ?? 0,
                         movieResults: movieListDTO.results.map { self.movie(from: $0) },
                         totalPages: movieListDTO.totalPages ?? 0)
    }

    private func movie(from movieDTO: MovieDTO) -> Movie {
        return Movie(title: movieDTO.title,
                     posterPath: movieDTO.posterPath,
                     averageScore: movieDTO.averageScore,
                     overview: movieDTO.overview)
    }
}
