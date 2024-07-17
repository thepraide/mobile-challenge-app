//
//  GetPopularMoviesUseCase.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

protocol GetPopularMoviesUseCaseType {
    func execute(page: Int) async throws -> [Movie]
}

final class GetPopularMoviesUseCase: GetPopularMoviesUseCaseType {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func execute(page: Int) async throws -> [Movie] {
        let api = PopularMoviesAPI(page: page)
        let response: MoviesAPIResponse = try await apiClient.perform(request: api)
        return response.results
    }
}
