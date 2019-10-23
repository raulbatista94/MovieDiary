//
//  MovieDiaryTests.swift
//  MovieDiaryTests
//
//  Created by Raul on 09/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import XCTest
import RxSwift

@testable import MovieDiary

class MovieDiaryTests: XCTestCase {
    
    private let dependencies = Dependencies()
    private let disposeBag = DisposeBag()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        dependencies.movieService.observeMovies(previouslyLoadedMovies: [])
            .subscribe(onNext: { movies in
                XCTAssertEqual(movies.isEmpty, false)
            }).disposed(by: disposeBag)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
