//
//  PlayingMoviesAPI.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

struct PlayingMoviesAPI: APIRequest {
    let endpoint: String = "/3/movie/now_playing"
    let page: Int
    var parameters: [String : String] {
        ["language": "en-US",
         "page": "\(page)"]
    }
    var headers: [String : String] = [:]
}
