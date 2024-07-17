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
    func showed(item: Movie)
    func liked(item: Movie, value: Bool)
}

final class HomeViewModel: HomeViewModelType {
    @Published var items: [Movie] = []
    @Published var isLoading: Bool =  true
    @Published var viewType: HomeViewType = .list
    @Published var featuring: Featuring = .popular {
        didSet {
            page = 1
            fetchMovies(loading: true)
        }
    }
    private var page: Int = 1
    private let logger = Logger()
    private let getPopularMovies: GetPopularMoviesUseCaseType
    private let getPlayingMovies: GetPlayingMoviesUseCaseType
    private let getPosterMovie: GetPosterUseCaseType
    private let saveFavoriteMovie: SaveMovieUseCaseType
    private let getFavoriteMovie: GetFavoriteMovieUseCase
    
    init(getPopularMovies: GetPopularMoviesUseCaseType,
         getPlayingMovies: GetPlayingMoviesUseCaseType,
         getPosterMovie: GetPosterUseCaseType,
         saveFavoriteMovie: SaveMovieUseCaseType,
         getFavoriteMovie: GetFavoriteMovieUseCase) {
        self.getPopularMovies = getPopularMovies
        self.getPlayingMovies = getPlayingMovies
        self.getPosterMovie = getPosterMovie
        self.saveFavoriteMovie = saveFavoriteMovie
        self.getFavoriteMovie = getFavoriteMovie
    }
    
    func viewAppear() {
        page = 1
        fetchMovies(loading: true)
    }
    
    func showed(item: Movie) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        Task {
            do {
                let liked = try await !getFavoriteMovie.execute(id: item.id).isEmpty
                await updateLiked(for: index, with: liked)
                if items[index].image == nil {
                    let data = try await getPosterMovie.execute(path: item.poster_path, size: .w154)
                    await updateImage(for: index, with: data)
                }
                if index == items.count/2 {
                    page = page + 1
                    fetchMovies(loading: false)
                }
            } catch {
                logger.error("💥 Error fetching poster for movie \(item.poster_path)")
            }
        }
    }
    
    func liked(item: Movie, value: Bool) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        Task {
            do {
                if value {
                    try await saveFavoriteMovie.execute(movie: item)
                } else {
                    //TODO: Delete from favorites
                }
                await updateLiked(for: index, with: value)
            } catch {
                logger.error("💥 Error saving movie \(error)")
            }
        }
    }
    
    private func fetchMovies(loading: Bool) {
        switch featuring {
        case .popular:
            fetchPopularMovies(loading: loading)
        case .playing:
            fetchPlayingMovies(loading: loading)
        }
    }
    
    private func fetchPopularMovies(loading: Bool) {
        Task {
            do {
                await isLoading(loading: loading)
                let movies = try await getPopularMovies.execute(page: page)
                if loading {
                    await isLoading(loading: false)
                    await set(movies: movies)
                } else  {
                    await add(movies: movies)
                }
            } catch {
                logger.error("💥 Error fetching popular movies \(error)")
            }
        }
    }
    
    private func fetchPlayingMovies(loading: Bool) {
        Task {
            do {
                await isLoading(loading: loading)
                let movies = try await getPlayingMovies.execute(page: page)
                if loading {
                    await isLoading(loading: false)
                    await set(movies: movies)
                } else {
                    await add(movies: movies)
                }
            } catch {
                logger.error("💥 Error fetching playing movies \(error)")
            }
        }
    }
    
    @MainActor
    private func isLoading(loading: Bool) {
        isLoading = loading
    }
    
    @MainActor
    private func set(movies: [Movie]) {
        items = movies
    }
    
    @MainActor
    private func add(movies: [Movie]) {
        items.append(contentsOf: movies)
    }
    
    @MainActor
    private func updateImage(for index: Int, with data: Data) {
        items[index].image = data
    }
    
    @MainActor
    private func updateLiked(for index: Int, with value: Bool) {
        items[index].liked = value
    }
}
