//
//  GetPosterMovieMock.swift
//  MoviesAppTests
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import Foundation
@testable import MoviesApp

final class GetPosterMovieMock: GetPosterUseCaseType {
    
    var executeSpy: [(String, ImagesAPISize)] = []
    var executeStub: (data: Data, error: Error?) = (data: Data(), error: nil)
    
    func execute(path: String, size: ImagesAPISize) async throws -> Data {
        executeSpy.append((path, size))
        if let error = executeStub.error {
            throw error
        } else {
            return executeStub.data
        }
    }
}
