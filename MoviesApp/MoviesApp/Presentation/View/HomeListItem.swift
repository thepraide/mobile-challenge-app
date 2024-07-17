//
//  HomeListItem.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

import SwiftUI

struct HomeListItem: View {
    
    var item: Movie
    
    var body: some View {
        HStack {
            if let image = item.image {
                Image(data: image)?
                    .resizable()
                    .frame(width: 100, height: 150)
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
