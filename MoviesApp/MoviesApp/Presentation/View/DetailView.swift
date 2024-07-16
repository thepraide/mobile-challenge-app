//
//  DetailView.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

import SwiftUI

struct DetailView<ViewModel: DetailViewModelType>: View {
    
    @StateObject var viewModel: ViewModel
    let imageBasePath: String = "https://image.tmdb.org/t/p/w500/"
    
    var body: some View {
        VStack() {
            AsyncImage(url: URL(string: imageBasePath + viewModel.movie.poster_path)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/3)
            
            makeBottomContainer()
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func makeBottomContainer() -> some View {
        VStack(alignment: .leading) {
            Text(viewModel.movie.title)
                .font(.title2)
                .bold()
            
            Text(viewModel.movie.release_date)
                .font(.caption2)
            
            HStack {
                ForEach(viewModel.genres, id: \.id) { genre in
                    Text(genre.name)
                }
            }
            
            HStack {
                Text("Popularity: \(viewModel.movie.popularity)")
                    .font(.caption2)
                Spacer()
                makeVoteAverage()
                    .frame(width: 40, height: 40)
            }
            .padding(.vertical, 10)
            
            Text(viewModel.movie.overview)
                .font(.caption)
        }
        .padding(20)
    }
    
    private func makeVoteAverage() -> some View {
        ZStack {
            Circle()
                .stroke(
                    Color.accentColor.opacity(0.5),
                    lineWidth: 5
                )
            Text("\(Int(viewModel.movie.vote_average*10))%")
                .font(.caption)
                .bold()
            Circle()
                .trim(from: 0, to: viewModel.movie.vote_average/10)
                .stroke(
                    Color.accentColor,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                )
        }
    }
}
