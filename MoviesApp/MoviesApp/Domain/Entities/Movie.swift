//
//  Movie.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

import Foundation

struct Movie: Identifiable, Decodable {
    var id = UUID()
    let title: String
    let poster_path: String
    let genre_ids: [Int]
    let overview: String
    let popularity: Double
    let release_date: Date
    let original_language: String
    let vote_average: Double
}
