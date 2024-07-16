//
//  GenresAPI.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

struct GenresAPI: APIRequest {
    let endpoint: String = "/3/genre/movie/list"
    var parameters: [String : String] {
        ["language": "en-US"]
    }
    var headers: [String : String] = [:]
}
