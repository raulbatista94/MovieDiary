//
//  MovieService.swift
//  MovieDiary
//
//  Created by Raul on 09/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import Alamofire
import RxSwift

final class MovieService {
    // If possible get rid of this
    private var moviePage: Int = 1
    
    private func getPopularMovies() -> Observable<[Movie]> {
        return Observable.create { emitter in
            //TODO
//            request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
            return Disposables.create()
        }
    }
}
