//
//  FavoriteMovie+Movie.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import Foundation

extension FavoriteMovie {
    
    func map() -> Movie {
        .init(id: Int(self.id),
              title: self.title ?? "",
              poster_path: "",
              genre_ids: self.genres ?? [],
              overview: self.overview ?? "",
              popularity: self.popularity,
              release_date: self.releaseDate ?? "",
              original_language: "",
              vote_average: self.votes,
              image: self.poster)
    }
}
