//
//  DetailViewModel.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

import SwiftUI

protocol DetailViewModelType: ObservableObject {
    var movie: Movie { get }
    var genres: [Genre] { get set }
}

final class DetailViewModel: DetailViewModelType {
    let movie: Movie
    var genres: [Genre] = []
    
    init(movie: Movie) {
        self.movie = movie
    }
}
