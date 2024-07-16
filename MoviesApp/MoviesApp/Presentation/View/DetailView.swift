//
//  DetailView.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

import SwiftUI

struct DetailView<ViewModel: DetailViewModelType>: View {
    
    @StateObject var viewModel: ViewModel
    let imageBasePath: String = "https://image.tmdb.org/t/p/w154/"
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageBasePath + viewModel.movie.poster_path)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
            
            Text(viewModel.movie.title)
            Text(viewModel.movie.release_date)
            HStack {
                ForEach(viewModel.genres, id: \.id) { genre in
                    Text(genre.name)
                }
            }
            Text(viewModel.movie.overview)
        }
    }
}
