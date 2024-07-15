//
//  HomeView.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 13/07/24.
//

import SwiftUI

enum HomeViewType {
    case list
    case grid
}

struct HomeView<ViewModel: HomeViewModelType>: View {
   
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                loadingView()
            } else if viewModel.viewType == .list {
                homeList()
            } else {
                homeGrid()
            }
        }.onAppear {
            viewModel.viewAppear()
        }
    }
    
    private func loadingView() -> some View {
        ProgressView()
              .progressViewStyle(CircularProgressViewStyle(tint: .blue))
              .scaleEffect(2.0, anchor: .center)
    }
    
    private func homeList() -> some View {
        List {
            ForEach(viewModel.items) { movie in
                HomeViewItem(movie: movie)
            }
        }
    }
    
    private func homeGrid() -> some View {
        Grid {
            
        }
    }
    
    func didTap(on: Movie) {
        
    }
}

struct HomeViewItem: View {
    
    let movie: Movie
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: movie.poster_path)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            
            Text(movie.title)
        }
    }
}
