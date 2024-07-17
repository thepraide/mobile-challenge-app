//
//  FavoritesViewModel.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import SwiftUI
import os

protocol FavoritesViewModelType: ObservableObject {
    var items: [Movie] { get set }
    func viewAppear()
}

final class FavoritesViewModel: FavoritesViewModelType {
    
    @Published var items: [Movie] = []
    private let logger = Logger()
    private let getFavoritesMovies: GetFavoriteMovieUseCaseType
    
    init(getFavoritesMovies: GetFavoriteMovieUseCaseType) {
        self.getFavoritesMovies = getFavoritesMovies
    }
    
    func viewAppear() {
        Task {
            do {
                let favorites = try await getFavoritesMovies.execute()
                await update(movies: favorites)
            } catch {
                logger.error("💥 Error getting favorites movies: \(error)")
            }
        }
    }
    
    @MainActor
    private func update(movies: [Movie]) {
        items = movies
    }
}
