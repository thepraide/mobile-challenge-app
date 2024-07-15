//
//  PopularMoviesAPI.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

struct PopularMoviesAPI: APIRequest {
    let endpoint: String = "/3/movie/popular"
    let page: Int
    var parameters: [String : String] {
        ["language": "en-US",
         "page": "\(page)"]
    }
    var headers: [String : String] = [:]
}
