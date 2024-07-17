//
//  FavoriteViewModule.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import SwiftUI

enum FavoriteViewModule {
    
    static func compose() -> some View {
        let favoritesMoviesUseCase = GetFavoriteMovieUseCase()
        let viewModel = FavoritesViewModel(getFavoritesMovies: favoritesMoviesUseCase)
        return FavoritesView(viewModel: viewModel)
    }
}
