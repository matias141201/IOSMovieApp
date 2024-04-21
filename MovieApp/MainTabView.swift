//
//  MainTabView.swift
//  MovieApp
//
//  Created by Matias Rodriguez on 20/04/2024.
//

import SwiftUI
struct MainTabView: View {
    var body: some View {
        TabView {
            MoviesView()
                .tabItem {
                    Image(systemName: "play.rectangle")
                }
            
            SearchMoviesView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }

        }
    }
}

#Preview {
    MainTabView()
}
