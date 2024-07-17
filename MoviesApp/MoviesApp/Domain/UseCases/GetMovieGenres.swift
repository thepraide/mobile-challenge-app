//
//  GetMovieGenres.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

import CoreData

protocol GetMovieGenresType {
    func execute(from ids: [Int]) async throws -> [Genre]
}

final class GetMovieGenres: GetMovieGenresType {
    
    private let persistence = PersistenceController.shared
    
    func execute(from ids: [Int]) async throws -> [Genre] {
        let fetchRequest: NSFetchRequest<LocalGenre>
        fetchRequest = LocalGenre.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id IN %@", ids)
        let context = persistence.container.viewContext
        let objects = try context.fetch(fetchRequest)
        return objects.map { Genre(id: Int($0.id), name: $0.name ?? "")}
    }
}
