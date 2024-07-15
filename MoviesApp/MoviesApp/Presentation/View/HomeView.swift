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
        .toolbar {
            ToolbarItem {
                Button(action: {
                    viewModel.viewType = viewModel.viewType == .grid ? .list : .grid
                }, label: {
                    if viewModel.viewType == .list {
                        Image(systemName: "list.bullet")
                    } else {
                        Image(systemName: "square.grid.3x3.fill")
                    }
                })
                .tint(.mint)
            }
        }
        .navigationTitle("Movies App")
    }
    
    private func loadingView() -> some View {
        ProgressView()
              .progressViewStyle(CircularProgressViewStyle(tint: .blue))
              .scaleEffect(2.0, anchor: .center)
    }
    
    private func homeList() -> some View {
        List(viewModel.items, id: \.self.title) { movie in
            ListItem(movie: movie)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(.clear)
    }
    
    private func homeGrid() -> some View {
        Grid {
            
        }
    }
    
    func didTap(on: Movie) {
        
    }
}
