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
    
    init() {
        AppStartModule.start()
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    HomeViewModule.compose()
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                
                
                NavigationView {
                    EmptyView()
                }
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
            }
        }
    }
}
