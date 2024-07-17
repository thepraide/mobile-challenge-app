//
//  ImagesAPI.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

enum ImagesAPISize: String {
    case original
    case w154
    case w500
}

struct ImagesAPI: APIRequest {
    var endpoint: String {
        "/t/p/\(size.rawValue+path)"
    }
    let path: String
    let size: ImagesAPISize
    var parameters: [String : String] = [:]
    var headers: [String : String] = [:]
}
