//
//  DetailViewModelTests.swift
//  MoviesAppTests
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import XCTest
@testable import MoviesApp

final class DetailViewModelTests: XCTestCase {
    
    func test_viewApper_executeGetMoviePosterAndGenres() {
        let mocks = DetailViewModelMocks()
        let sut = makeSUT(mocks: mocks)
        
        sut.viewAppear()
        
        let expectation = expectation(description: "Loading")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(mocks.getPoster.executeSpy.count, 1)
        XCTAssertEqual(mocks.getMovieGenres.executeSpy.count, 1)
    }
    
    struct DetailViewModelMocks {
        let movie = dummyMovie()
        let getMovieGenres = GetMovieGenresMock()
        let getPoster = GetPosterMovieMock()
    }
    
    private func makeSUT(mocks: DetailViewModelMocks) -> DetailViewModel {
        DetailViewModel(movie: mocks.movie,
                        getMovieGenres: mocks.getMovieGenres,
                        getPoster: mocks.getPoster)
    }
}

func dummyMovie() -> Movie {
    Movie(id: 1,
          title: "Rick Movie",
          poster_path: "poster_path",
          genre_ids: [1,2,3],
          overview: "Amazing",
          popularity: 10,
          release_date: "2024-12-11",
          original_language: "us-en",
          vote_average: 10)
}
