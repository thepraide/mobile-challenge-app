//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

import SwiftUI
import os

protocol HomeViewModelType: ObservableObject {
    var items: [Movie] { get set }
    var isLoading: Bool { get set }
    var viewType: HomeViewType { get set }
    func didTap(on: Movie)
    func viewAppear()
}

final class HomeViewModel: HomeViewModelType {
    @Published var items: [Movie] = []
    @Published var isLoading: Bool =  true
    @Published var viewType: HomeViewType = .list
    
    private let logger = Logger()
    private let getPopularMovies: GetPopularMoviesUseCaseType
    
    init(getPopularMovies: GetPopularMoviesUseCaseType) {
        self.getPopularMovies = getPopularMovies
    }
    
    func didTap(on: Movie) {
        
    }
    
    func viewAppear() {
        isLoading = true
        //TODO: Fetch
        Task {
            do {
                let movies = try await getPopularMovies.execute()
                isLoading = false
                items = movies
            } catch {
                logger.error("💥 Error fetching popular movies \(error)")
            }
        }
    }
}
