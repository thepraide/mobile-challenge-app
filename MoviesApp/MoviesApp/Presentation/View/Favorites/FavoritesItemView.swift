//
//  FavoritesItemView.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import SwiftUI

struct FavoriteItemView: View {
    
    let item: Movie
    
    var body: some View {
        HStack {
            if let image = item.image {
                Image(data: image)?
                    .resizable()
                    .frame(width: 100, height: 150)
                    .overlay {
                        LinearGradient(gradient: Gradient(colors: [.black, .clear, .clear]), startPoint: .top, endPoint: .bottom)
                    }
                    .cornerRadius(10)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 150)
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(item.release_date)
                    .font(.caption)
                    .padding(.bottom, 3)
                Text(item.overview)
                    .font(.caption)
                    .lineLimit(2)
                
            }
            
            VotesView(average: item.vote_average)
                .frame(width: 40, height: 40)
        }
    }
}

