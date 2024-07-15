//
//  LocalTokenProvider.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

import Foundation

enum TokenProviderError: Error {
    case source
    case empty
}

struct LocalTokenProvider: TokenProvider {
    
    func provide() throws -> String {
        guard let info = Bundle.main.infoDictionary else {
            throw TokenProviderError.source
        }
        
        guard let token = info["TOKEN"] as? String, !token.isEmpty else {
            throw TokenProviderError.empty
        }
        
        return token
    }
}
