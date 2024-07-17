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
    @Published var movie: Movie
    
    private let getMovieGenres: GetMovieGenresType
    private let getPoster: GetPosterUseCaseType
    
    init(movie: Movie,
         getMovieGenres: GetMovieGenresType,
         getPoster: GetPosterUseCaseType) {
        self.movie = movie
        self.getMovieGenres = getMovieGenres
        self.getPoster = getPoster
    }
    
    func viewAppear() {
        Task {
            do {
                async let image = getPoster.execute(path: movie.poster_path, size: .w500)
                async let genres = getMovieGenres.execute(from: movie.genre_ids)
                let result = (try await image, try await genres)
                await update(image: result.0)
                await update(genres: result.1)
            } catch {
                logger.error("💥 Error getting movie genres: \(error)")
            }
        }
    }
    
    @MainActor
    private func update(genres: [Genre]) {
        self.genres = genres
    }
    
    @MainActor
    private func update(image: Data) {
        self.movie.image = image
    }
}
