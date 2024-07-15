//
//  APIDecoder.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

import Foundation

protocol APIDecoder {
    func decode<T: Decodable>(data: Data) throws -> T
}

struct DefaultAPIDecoder: APIDecoder {
    func decode<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
