//
//  DetailViewModule.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

import SwiftUI

enum DetailViewModule {
    
    static func compose(movie: Movie) -> some View {
        let getMoviesGenres = GetMovieGenres()
        let getPosterUseCase = GetPosterUseCase()
        let viewModel = DetailViewModel(movie: movie,
                                        getMovieGenres: getMoviesGenres,
                                        getPoster: getPosterUseCase)
        return DetailView(viewModel: viewModel)
    }
}
