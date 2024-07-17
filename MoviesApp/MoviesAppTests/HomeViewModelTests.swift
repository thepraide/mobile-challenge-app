//
//  HomeViewModelTests.swift
//  MoviesAppTests
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import XCTest
@testable import MoviesApp

final class HomeViewModelTests: XCTestCase {
    
    func test_viewApper_executeFecthPopularMovies() {
        let mocks = HomeViewModelMocks()
        let sut = makeSUT(mocks: mocks)
        
        sut.viewAppear()
        XCTAssertTrue(sut.isLoading)
        
        let expectation = expectation(description: "Loading")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(mocks.getPopularMovies.executeSpy.count, 1)
        XCTAssertEqual(mocks.getPopularMovies.executeSpy.first, 1)
    }

    struct HomeViewModelMocks {
        let getPopularMovies = GetPopularMoviesMock()
        let getPlayingMovies = GetPlayingMoviesMock()
        let getPosterMovie = GetPosterMovieMock()
        let saveFavoriteMovie = SaveFavoriteMovieMock()
        let getFavoriteMovie = GetFavoriteMovieUseCase()
    }
    
    fileprivate func makeSUT(mocks: HomeViewModelMocks) -> HomeViewModel {
        HomeViewModel(getPopularMovies: mocks.getPopularMovies,
                      getPlayingMovies: mocks.getPlayingMovies,
                      getPosterMovie: mocks.getPosterMovie,
                      saveFavoriteMovie: mocks.saveFavoriteMovie,
                      getFavoriteMovie: mocks.getFavoriteMovie)
    }
}
