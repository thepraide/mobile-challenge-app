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
            .overlay {
                LinearGradient(gradient: Gradient(colors: [.black, .clear, .clear]), startPoint: .top, endPoint: .bottom)
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    print("liked")
                } label: {
                    Image(systemName: "heart")
                        .padding([.top, .trailing], 10)
                }
                .clipped()
                .buttonStyle(BorderlessButtonStyle())
            }
            .cornerRadius(10)
            
            Text(movie.title)
                .font(.footnote)
                .bold()
        }
    }
}
