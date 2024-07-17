//
//  GetPosterUseCase.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

import Foundation

protocol GetPosterUseCaseType {
    func execute(path: String, size: ImagesAPISize) async throws -> Data
}

final class GetPosterUseCase: GetPosterUseCaseType {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = RestAPIClient(host: "https://image.tmdb.org")) {
        self.apiClient = apiClient
    }
    
    func execute(path: String, size: ImagesAPISize) async throws -> Data {
        let api = ImagesAPI(path: path, size: size)
        let respose: Data = try await apiClient.perform(request: api)
        return respose
    }
}
