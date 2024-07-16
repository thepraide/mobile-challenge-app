//
//  DetailViewModule.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

import SwiftUI

enum DetailViewModule {
    
    static func compose(movie: Movie) -> some View {
        let viewModel = DetailViewModel(movie: movie)
        return DetailView(viewModel: viewModel)
    }
}
