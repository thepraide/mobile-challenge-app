//
//  DetailViewModel.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

import SwiftUI
import os

protocol DetailViewModelType: ObservableObject {
    var movie: Movie { get }
    var genres: [Genre] { get set }
    func viewAppear()
}

final class DetailViewModel: DetailViewModelType {

    private let logger = Logger()
    @Published var genres: [Genre] = []
    
    let movie: Movie
    let getMovieGenres: GetMovieGenresType
    
    init(movie: Movie,
         getMovieGenres: GetMovieGenresType) {
        self.movie = movie
        self.getMovieGenres = getMovieGenres
    }
    
    func viewAppear() {
        Task {
            do {
                let genres = try await getMovieGenres.execute(from: movie.genre_ids)
                await update(genres: genres)
            } catch {
                logger.error("💥 Error getting movie genres: \(error)")
            }
        }
    }
    
    @MainActor
    private func update(genres: [Genre]) {
        self.genres = genres
    }
}
