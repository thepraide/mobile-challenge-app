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
    var featuring: Featuring { get set }
    func viewAppear()
}

final class HomeViewModel: HomeViewModelType {
    @Published var items: [Movie] = []
    @Published var isLoading: Bool =  true
    @Published var viewType: HomeViewType = .list
    @Published var featuring: Featuring = .popular {
        didSet {
            featuringChange()
        }
    }
    
    private let logger = Logger()
    private let getPopularMovies: GetPopularMoviesUseCaseType
    private let getPlayingMovies: GetPlayingMoviesUseCaseType
    
    init(getPopularMovies: GetPopularMoviesUseCaseType,
         getPlayingMovies: GetPlayingMoviesUseCaseType) {
        self.getPopularMovies = getPopularMovies
        self.getPlayingMovies = getPlayingMovies
    }
    
    func viewAppear() {
        fetchPopularMovies()
    }
    
    func featuringChange() {
        switch featuring {
        case .popular:
            fetchPopularMovies()
        case .playing:
            fetchPlayingMovies()
        }
    }
    
    private func fetchPopularMovies() {
        Task {
            do {
                await update(loading: true, movies: [])
                let movies = try await getPopularMovies.execute()
                await update(movies: movies)
            } catch {
                logger.error("💥 Error fetching popular movies \(error)")
            }
        }
    }
    
    private func fetchPlayingMovies() {
        Task {
            do {
                await update(loading: true, movies: [])
                let movies = try await getPlayingMovies.execute()
                await update(movies: movies)
            } catch {
                logger.error("💥 Error fetching playing movies \(error)")
            }
        }
    }
    
    @MainActor
    private func update(loading: Bool = false, movies: [Movie]) {
        isLoading = loading
        items = movies
    }
}
