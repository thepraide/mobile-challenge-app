//
//  GetMovieGenresMock.swift
//  MoviesAppTests
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import Foundation
@testable import MoviesApp

final class GetMovieGenresMock: GetMovieGenresType {
    
    var executeSpy: [[Int]] = []
    var executeStub: (genres: [Genre], error: Error?) = (genres: [], error: nil)
    
    func execute(from ids: [Int]) async throws -> [Genre] {
        executeSpy.append(ids)
        if let error = executeStub.error {
            throw error
        } else {
            return executeStub.genres
        }
    }
}
