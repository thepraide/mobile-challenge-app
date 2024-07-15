//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 15/07/24.
//

import SwiftUI

protocol HomeViewModelType: ObservableObject {
    var items: [Movie] { get set }
    var isLoading: Bool { get set }
    var viewType: HomeViewType { get set }
    func didTap(on: Movie)
    func viewAppear()
}

final class HomeViewModel: HomeViewModelType {
    @Published var items: [Movie] = []
    @Published var isLoading: Bool =  true
    @Published var viewType: HomeViewType = .list
    
    func didTap(on: Movie) {
        
    }
    
    func viewAppear() {
        isLoading = true
        //TODO: Fetch
    }
}
