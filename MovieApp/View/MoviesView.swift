//
//  MoviesView.swift
//  MovieApp
//
//  Created by Matias Rodriguez on 13/04/2024.
//

import SwiftUI
import Kingfisher

struct MoviesView: View {
    @StateObject private var viewModel = MoviesViewModel()
    
    var gridITemLayout = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Coming soon")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridITemLayout, spacing: 20) {
                            ForEach(viewModel.upcomingMovies, id: \.id) { movie in
                                NavigationLink {
                                    MovieDetailView(movie: movie)
                                        
                                } label: {
                                    KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                        .resizable()
                                        .placeholder { progress in
                                            ProgressView()
                                        }
                                        .cornerRadius(12)
                                        .frame(width: 150, height: 210)
                                        .task {
                                            if viewModel.hasReachedEnd(of: movie) && !viewModel.isFetching {
                                                await viewModel.fetchNextSetOfMovies()
                                            }
                                        }
                                }
                            }
                        }
                    }
                    
                    Text("Now in theater")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridITemLayout, spacing: 20) {
                            ForEach(viewModel.nowPlayingMovies, id: \.id) { movie in
                                NavigationLink {
                                    MovieDetailView(movie: movie)
                                } label: {
                                    KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                        .resizable()
                                        .placeholder { progress in
                                            ProgressView()
                                        }
                                        .cornerRadius(12)
                                        .frame(width: 150, height: 210)
                                }
                            }
                        }
                    }
                    
                    Text("Tranding")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridITemLayout, spacing: 20) {
                            ForEach(viewModel.trendingMovies, id: \.id) { movie in
                                NavigationLink {
                                    MovieDetailView(movie: movie)
                                } label: {
                                    KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                        .resizable()
                                        .placeholder { progress in
                                            ProgressView()
                                        }
                                        .cornerRadius(12)
                                        .frame(width: 150, height: 210)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    MoviesView()
}
