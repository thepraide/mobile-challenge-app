//
//  HomeGridItem.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

import SwiftUI

struct HomeGridItem: View {
    
    let movie: Movie
    let imageBasePath: String = "https://image.tmdb.org/t/p/w154/"
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageBasePath + movie.poster_path)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 100, height: 150)
            .cornerRadius(5)
            
            Text(movie.title)
                .font(.footnote)
                .bold()
        }
    }
}
