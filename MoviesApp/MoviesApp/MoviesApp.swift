//
//  MoviesApp.swift
//  MoviesApp
//
//  Created by Ricardo Hernandez on 13/07/24.
//

import SwiftUI

@main
struct MoviesApp: App {
    
    let persistenceController = PersistenceController.shared
    @ObservedObject var homeRouter = HomeRouter()
    
    init() {
        AppStartModule.start()
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack(path: $homeRouter.navPath) {
                    HomeViewModule.compose()
                        .navigationDestination(for: HomeRouter.Destination.self) { destination in
                            switch destination {
                            case .detail(movie: let movie):
                                DetailViewModule.compose(movie: movie)
                            }
                        }
                }
                .environmentObject(homeRouter)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                
                
                NavigationView {
                    FavoriteViewModule.compose()
                }
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
            }
        }
    }
}
