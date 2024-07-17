//
//  HomeGridItem.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

import SwiftUI

struct HomeGridItem: View {
    
    let item: Movie
    var itemLiked: ((Bool) -> Void)
    
    var body: some View {
        VStack {
            Group {
                if let image = item.image {
                    Image(data: image)?
                        .resizable()
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
                        .overlay {
                            LinearGradient(gradient: Gradient(colors: [.black, .clear, .clear]), startPoint: .top, endPoint: .bottom)
                        }
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 150)
                        .foregroundColor(.gray)
                }
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    itemLiked(!(item.liked ?? false))
                } label: {
                    Image(systemName: item.liked ?? false ? "heart.fill" : "heart")
                        .padding([.top, .trailing], 10)
                }
                .clipped()
                .buttonStyle(BorderlessButtonStyle())
            }
            .cornerRadius(10)
            
            Text(item.title)
                .font(.footnote)
                .bold()
        }
    }
}
