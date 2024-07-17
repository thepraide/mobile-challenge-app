//
//  GetPopularMoviesMock.swift
//  MoviesAppTests
//
//  Created by Ricardo Hernandez on 17/07/24.
//

@testable import MoviesApp

final class GetPopularMoviesMock: GetPopularMoviesUseCaseType {
    
    var executeSpy: [Int] = []
    var executeStub: (movies: [Movie], error: Error?) = (movies: [], error: nil)
    
    func execute(page: Int) async throws -> [Movie] {
        executeSpy.append(page)
        if let error = executeStub.error {
            throw error
        } else {
            return executeStub.movies
        }
    }
}
