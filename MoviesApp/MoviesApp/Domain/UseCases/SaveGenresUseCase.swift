//
//  SaveGenresUseCase.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

import CoreData

protocol SaveGenresUseCaseType {
    func execute(genre: Genre) async throws
    func execute(genres: [Genre]) async throws
}

final class SaveGenresUseCase: SaveGenresUseCaseType {
    
    private let persistence = PersistenceController.shared
    
    func execute(genre: Genre) async throws {
        let context = persistence.container.viewContext
        let local = LocalGenre(context: context)
        local.id = Int64(genre.id)
        local.name = genre.name
        try context.save()
    }
    
    func execute(genres: [Genre]) async throws {
        let context = persistence.container.viewContext
        for genre in genres {
            let local = LocalGenre(context: context)
            local.id = Int64(genre.id)
            local.name = genre.name
        }
        
        try context.save()
    }
}
