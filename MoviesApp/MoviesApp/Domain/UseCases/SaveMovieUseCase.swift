//
//  SaveMovieUseCase.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

protocol SaveMovieUseCaseType  {
    func execute(movie: Movie) async throws
}

final class SaveMovieUseCase: SaveMovieUseCaseType {
    
    private let persistence = PersistenceController.shared
    
    func execute(movie: Movie) async throws {
        let context = persistence.container.viewContext
        let local = FavoriteMovie(context: context)
        local.id = Int64(movie.id)
        local.title = movie.title
        local.overview = movie.overview
        local.popularity = movie.popularity
        local.releaseDate = movie.release_date
        local.votes = movie.vote_average
        local.poster = movie.image
        local.genres = movie.genre_ids

        try context.save()
    }
}
