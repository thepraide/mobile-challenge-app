//
//  AppStartModule.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

import os

enum AppStartModule  {
    
    static func start() {
        let client = RestAPIClient(host: "https://api.themoviedb.org")
        let authClient = AuthRestAPIClient(client: client, tokenProvider: LocalTokenProvider())
        let getGenresUseCase = GetGenresUseCase(apiClient: authClient)
        let saveGenresUseCase = SaveGenresUseCase()
        let logger = Logger()
        Task {
            do {
                let genres = try await getGenresUseCase.execute()
                try await saveGenresUseCase.execute(genres: genres)
            } catch {
                logger.error("💥 Error fetching popular movies \(error)")
            }
        }
    }
}
