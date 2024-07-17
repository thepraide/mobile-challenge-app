//
//  GetFavoriteMovieUseCase.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import CoreData

protocol GetFavoriteMovieUseCaseType {
    func execute() async throws -> [Movie]
    func execute(id: Int) async throws -> [Movie]
}

final class GetFavoriteMovieUseCase: GetFavoriteMovieUseCaseType {
    
    private let persistence = PersistenceController.shared
    
    func execute() async throws -> [Movie] {
        let fetchRequest: NSFetchRequest<FavoriteMovie>
        fetchRequest = FavoriteMovie.fetchRequest()
        let context = persistence.container.viewContext
        let objects = try context.fetch(fetchRequest)
        return objects.map { $0.map() }
    }
    
    func execute(id: Int) async throws -> [Movie] {
        let fetchRequest: NSFetchRequest<FavoriteMovie>
        fetchRequest = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        let context = persistence.container.viewContext
        let objects = try context.fetch(fetchRequest)
        return objects.map { $0.map() }
    }
}
