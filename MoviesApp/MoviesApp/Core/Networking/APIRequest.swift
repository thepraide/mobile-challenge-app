//
//  APIRequest.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

protocol APIRequest {
    var endpoint: String { get }
    var parameters: [String: String] { get }
    var headers: [String: String] { get set }
}
