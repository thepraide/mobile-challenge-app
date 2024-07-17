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
        let viewContext = persistence.container.viewContext
        let local = LocalGenre(context: viewContext)
        local.id = Int64(genre.id)
        local.name = genre.name
        try viewContext.save()
    }
    
    func execute(genres: [Genre]) async throws {
        let viewContext = persistence.container.viewContext
        for genre in genres {
            let local = LocalGenre(context: viewContext)
            local.id = Int64(genre.id)
            local.name = genre.name
        }
        
        try viewContext.save()
    }
}
