//
//  GetGenresUseCase.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

protocol GetGenresUseCaseType {
    func execute() async throws -> [Genre]
}

final class GetGenresUseCase: GetGenresUseCaseType {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func execute() async throws -> [Genre] {
        let api = GenresAPI()
        let response: GenresAPIResponse = try await apiClient.perform(request: api)
        return response.genres
    }
    
}
