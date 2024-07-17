//
//  SaveFavoriteMovieMock.swift
//  MoviesAppTests
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import Foundation
@testable import MoviesApp

final class SaveFavoriteMovieMock: SaveMovieUseCaseType {
    
    var executeSpy: [Movie] = []
    var executeStub: Error? = nil
    
    func execute(movie: Movie) async throws {
        executeSpy.append(movie)
        if let error = executeStub {
            throw error
        } else {
            return
        }
    }
}

