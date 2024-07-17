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
        ScrollView {
            VStack() {
                makeHeader()
                makeBottomContainer()
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            viewModel.viewAppear()
        }
    }
    
    private func makeHeader() -> some View {
        Group {
            if let image = viewModel.movie.image {
                Image(data: image)?
                    .resizable()
            } else {
                EmptyView()
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/2)
        .overlay {
            LinearGradient(colors: [.black, .clear],
                           startPoint: .top, endPoint: .bottom)
        }
    }
    
    private func makeBottomContainer() -> some View {
        VStack(alignment: .leading) {
            Text(viewModel.movie.title)
                .font(.title2)
                .bold()
            
            Text(viewModel.movie.release_date)
                .font(.caption2)
            
            GenresList(genres: viewModel.genres)
            
            HStack {
                Text("Popularity: \(viewModel.movie.popularity)")
                    .font(.caption2)
                Spacer()
                VotesView(average: viewModel.movie.vote_average)
                    .frame(width: 40, height: 40)
            }
            .padding(.vertical, 10)
            
            Text(viewModel.movie.overview)
                .font(.caption)
        }
        .padding(20)
    }
}
