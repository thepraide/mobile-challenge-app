//
//  GetFavoriteMovieMock.swift
//  MoviesAppTests
//
//  Created by Ricardo Hernandez on 17/07/24.
//

@testable import MoviesApp

final class GetFavoriteMovieMock: GetFavoriteMovieUseCaseType {
    
    var executeSpyCount: Int = 0
    var executeSpy: [Int] = []
    var executeStub: (movies: [Movie], error: Error?) = (movies: [], error: nil)
    
    func execute() async throws -> [Movie] {
        executeSpyCount+=1
        if let error = executeStub.error {
            throw error
        } else {
            return executeStub.movies
        }
    }
    
    func execute(id: Int) async throws -> [Movie] {
        executeSpy.append(id)
        if let error = executeStub.error {
            throw error
        } else {
            return executeStub.movies
        }
    }
}

