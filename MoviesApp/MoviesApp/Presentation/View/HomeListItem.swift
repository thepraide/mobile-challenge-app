//
//  HomeListItem.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

import SwiftUI

struct HomeListItem: View {
    
    let item: Movie
    var itemLiked: ((Bool) -> Void)
    
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
            
            VStack {
                Button {
                    itemLiked(!(item.liked ?? false))
                } label: {
                    Image(systemName: item.liked ?? false ? "heart.fill" : "heart")
                        .padding(.top, 10)
                }
                .clipped()
                .buttonStyle(BorderlessButtonStyle())
                Spacer()
            }
        }
    }
}
