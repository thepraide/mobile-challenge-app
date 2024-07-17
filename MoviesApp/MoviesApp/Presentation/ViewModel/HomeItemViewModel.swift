//
//  HomeItemViewModel.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 16/07/24.
//

import SwiftUI

protocol HomeItemViewModelType: ObservableObject {
    var image: UIImage? { get set }
}

final class HomeItemViewModel: HomeItemViewModelType {
    @Published var image: UIImage? = nil
    
    
}
