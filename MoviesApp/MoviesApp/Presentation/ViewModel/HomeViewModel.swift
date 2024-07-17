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
    func show(item: Movie)
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
    private let getPosterMovie: GetPosterUseCaseType
    
    init(getPopularMovies: GetPopularMoviesUseCaseType,
         getPlayingMovies: GetPlayingMoviesUseCaseType,
         getPosterMovie: GetPosterUseCaseType) {
        self.getPopularMovies = getPopularMovies
        self.getPlayingMovies = getPlayingMovies
        self.getPosterMovie = getPosterMovie
    }
    
    func viewAppear() {
        fetchPopularMovies()
    }
    
    func show(item: Movie) {
        guard let index = items.firstIndex(where: { $0.id == item.id }),
              items[index].image == nil
        else { return }
        Task {
            do {
                let data = try await getPosterMovie.execute(path: item.poster_path, size: .w154)
                await updateImage(for: index, with: data)
            } catch {
                logger.error("💥 Error fetching poster for movie \(item.poster_path)")
            }
        }
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
    
    @MainActor
    private func updateImage(for index: Int, with data: Data) {
        items[index].image = data
    }
}
