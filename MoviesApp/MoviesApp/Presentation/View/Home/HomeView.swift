//
//  HomeView.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 13/07/24.
//

import SwiftUI

enum HomeViewType {
    case list
    case grid
    
    func icon() -> String {
        switch self {
        case .list: return "list.bullet"
        case .grid: return "square.grid.3x3.fill"
        }
    }
}

enum Featuring: String, CaseIterable {
    case popular = "Most Popular"
    case playing = "Now Playing"
}

struct HomeView<ViewModel: HomeViewModelType>: View {
   
    @EnvironmentObject var router: HomeRouter
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Group {
            if let error = viewModel.errorBanner {
                Text(error)
            }
            if viewModel.isLoading {
                loadingView()
            } else {
                switch viewModel.viewType {
                case .list: homeList()
                case .grid: homeGrid()
                }
            }
        }.toolbar {
            ToolbarItem {
                Button(action: {
                    viewModel.viewType = viewModel.viewType == .grid ? .list : .grid
                }, label: {
                    Image(systemName: viewModel.viewType.icon())
                })
                .tint(.accentColor)
            }
        }
        .navigationTitle("Movies App")
        .onAppear {
            viewModel.viewAppear()
        }
    }
    
    func makeFeaturingPicker() -> some View {
        Picker("Featuring", selection: $viewModel.featuring) {
            ForEach(Featuring.allCases, id: \.rawValue) { type in
                Text(type.rawValue).tag(type)
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
    
    private func loadingView() -> some View {
        ProgressView()
              .progressViewStyle(CircularProgressViewStyle(tint: .blue))
              .scaleEffect(2.0, anchor: .center)
    }
    
    private func homeList() -> some View {
        VStack {
            makeFeaturingPicker()
            
            List(viewModel.items, id: \.self.id) { item in
                HomeListItem(item: item) { value in
                    viewModel.liked(item: item, value: value)
                }
                .listRowSeparator(.hidden)
                .task {
                    viewModel.showed(item: item)
                }
                .onTapGesture {
                    router.navigate(to: .detail(movie: item))
                }
            }
            .listStyle(.plain)
            .background(.clear)
        }
    }
    
    private func homeGrid() -> some View {
        VStack {
            makeFeaturingPicker()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())] , spacing: 20) {
                    ForEach(viewModel.items, id: \.self.id) { item in
                        HomeGridItem(item: item) { value in
                            viewModel.liked(item: item, value: value)
                        }
                        .task {
                            viewModel.showed(item: item)
                        }
                        .onTapGesture {
                            router.navigate(to: .detail(movie: item))
                        }
                    }
                }
            }
        }
    }
}
