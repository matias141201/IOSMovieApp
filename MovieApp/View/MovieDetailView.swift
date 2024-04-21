//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Matias Rodriguez on 14/04/2024.
//

import SwiftUI
import Kingfisher
import YouTubeiOSPlayerHelper

struct MovieDetailView: View {
    @StateObject var viewModel = TrailerViewModel()
    @State private var urlSelected = ""
    @State private var showTrailer = false
    
    let movie: DataMovie
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    //Imagen
                    RemoteImageMovie(url: movie.backdrop_path ?? "")
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .shadow(radius: 12)
                        .cornerRadius(12)
                        .padding(.horizontal, 15)
                    
                    //Description
                    Text(movie.overview ?? "")
                        .font(.body)
                        .padding(.horizontal, 15)
                    
                    if ((movie.release_date?.isEmpty) != nil) {
                        Text("Release: \(movie.release_date ?? "")")
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                            .padding(.bottom, 15)
                    }
                    
                    
                    //TrailerView
                    if !viewModel.listOfTrailers.isEmpty {
                        
                        Text("Trailers")
                            .font(.title2)
                            .foregroundColor(.accentColor)
                            .padding(.horizontal, 15)
                        
                        YTWrapper(videoID: "\(viewModel.listOfTrailers[0].key)")
                            .frame(height: 200)
                            .cornerRadius(12)
                            .padding(.horizontal, 15)
                            .padding(.bottom, 15)
                    } else {
                        
                    }
                    
                    
                    //Trailers
                    ScrollView {
                        ForEach(viewModel.listOfTrailers, id: \.key) { trailer in
                                TrailerCellView(urlMovie: movie.backdrop_path ?? "", trailer: trailer)
                                        .onTapGesture {
                                            let url = URL(string: "https://www.youtube.com/watch?v=\(trailer.key)")
                                            if let url = url {
                                                UIApplication.shared.open(url)
                                                }
                                            }
                                           }
                                       }
                                   }
                                   .onAppear {
                                       viewModel.getTrailers(id: movie.id ?? 123)
                }
                .padding(5)
            }
            .navigationBarTitle(movie.title ?? movie.original_title ?? "", displayMode: .inline)
        }
    }
}

#Preview {
    MovieDetailView(movie: MockData.movie)
}

struct YTWrapper : UIViewRepresentable {
    var videoID : String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
    }
}
