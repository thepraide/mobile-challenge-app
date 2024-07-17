//
//  HomeViewModule.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

import SwiftUI

enum HomeViewModule {
    
    static func compose() -> some View {
        let client = RestAPIClient(host: "https://api.themoviedb.org")
        let authClient = AuthRestAPIClient(client: client, tokenProvider: LocalTokenProvider())
        let popularMoviesUseCase = GetPopularMoviesUseCase(apiClient: authClient)
        let playingMoviesUseCase = GetPlayingMoviesUseCase(apiClient: authClient)
        let getPosterUseCase = GetPosterUseCase()
        let saveFavoriteMovieUseCase = SaveMovieUseCase()
        let getFavoriteMovieUseCase = GetFavoriteMovieUseCase()
        let viewModel = HomeViewModel(getPopularMovies: popularMoviesUseCase,
                                      getPlayingMovies: playingMoviesUseCase, 
                                      getPosterMovie: getPosterUseCase,
                                      saveFavoriteMovie: saveFavoriteMovieUseCase,
                                      getFavoriteMovie: getFavoriteMovieUseCase)
        return HomeView(viewModel: viewModel)
    }
}
