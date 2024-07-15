//
//  MoviesAPIResponse.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

struct MoviesAPIResponse: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
