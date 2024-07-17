//
//  FavoritesView.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import SwiftUI

struct FavoritesView<ViewModel: FavoritesViewModelType>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.items, id: \.self.id) { item in
            FavoriteItemView(item: item)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(.clear)
        .navigationTitle("Favorites")
        .onAppear {
            viewModel.viewAppear()
        }
    }
}
