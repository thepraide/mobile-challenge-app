//
//  GetPlayingMoviesUseCase.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

protocol GetPlayingMoviesUseCaseType {
    func execute(page: Int) async throws -> [Movie]
}

final class GetPlayingMoviesUseCase: GetPlayingMoviesUseCaseType {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func execute(page: Int) async throws -> [Movie] {
        let api = PlayingMoviesAPI(page: page)
        let response: MoviesAPIResponse = try await apiClient.perform(request: api)
        return response.results
    }
}
