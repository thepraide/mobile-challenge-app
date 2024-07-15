//
//  GetPlayingMoviesUseCase.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

protocol GetPlayingMoviesUseCaseType {
    func execute() async throws -> [Movie]
}

final class GetPlatingMoviesUseCase: GetPopularMoviesUseCaseType {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func execute() async throws -> [Movie] {
        let api = PlayingMoviesAPI(page: 1)
        let response: MoviesAPIResponse = try await apiClient.perform(request: api)
        return response.results
    }
}
