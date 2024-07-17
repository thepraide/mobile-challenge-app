//
//  VotesView.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 17/07/24.
//

import SwiftUI

struct VotesView: View {
    
    let average: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.accentColor.opacity(0.5),
                    lineWidth: 5
                )
            Text("\(Int(average*10))%")
                .font(.caption)
                .bold()
            Circle()
                .trim(from: 0, to: average/10)
                .stroke(
                    Color.accentColor,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
    }
}
