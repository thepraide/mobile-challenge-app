//
//  GetPopularMoviesUseCase.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

protocol GetPopularMoviesUseCaseType {
    func execute() async throws -> [Movie]
}

final class GetPopularMoviesUseCase: GetPopularMoviesUseCaseType {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func execute() async throws -> [Movie] {
        let api = PopularMoviesAPI(page: 1)
        let movies: [Movie] = try await apiClient.perform(request: api)
        return movies
    }
}
