//
//  GenresList.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import SwiftUI

struct GenresList: View {
    
    let genres: [Genre]
    
    var body: some View {
        HStack {
            ForEach(genres, id: \.id) { genre in
                Text(genre.name)
                    .font(.caption2)
                    .padding(5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.accent, lineWidth: 1)
                    }
            }
        }
    }
}
