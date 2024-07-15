//
//  TokenProvider.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

protocol TokenProvider {
    func provide() throws -> String
}
