//
//  HomeListItem.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

import SwiftUI

struct HomeListItem: View {
    
    let movie: Movie
    let imageBasePath: String = "https://image.tmdb.org/t/p/w154/"
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageBasePath + movie.poster_path)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 100, height: 150)
            .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(movie.release_date)
                    .font(.caption)
                    .padding(.bottom, 3)
                Text(movie.overview)
                    .font(.caption)
                    .lineLimit(2)
                   
            }
            
            VStack {
                Button {
                    print("liked")
                } label: {
                    Image(systemName: "heart")
                        .padding(.top, 10)
                }
                .clipped()
                .buttonStyle(BorderlessButtonStyle())
                Spacer()
            }
        }
    }
}
