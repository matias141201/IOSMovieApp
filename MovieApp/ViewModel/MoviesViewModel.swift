//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by Matias Rodriguez on 13/04/2024.
//

import Foundation

class MoviesViewModel: ObservableObject {
    @Published var upcomingMovies: [DataMovie] = []
    @Published var nowPlayingMovies: [DataMovie] = []
    @Published var trendingMovies: [DataMovie] = []
    @Published private(set) var viewState: ViewState?
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    private var page = 1
    private var totalPages: Int?
    
    init() {
        getListOfUpcomingMovies()
        getMoviesNowPlaying()
        getMoviesTrending()
    }
    
    func getListOfUpcomingMovies() {
        viewState = .loading
        defer { viewState = .finished }
        
        NetworkManager.shared.getLisOfUpcomingMovies(numPage: page) { [weak self] result in
            DispatchQueue.main.async {
                
                guard let self else { return }
                switch result {
                case .success(let result):
                    self.totalPages = result.total_pages
                    self.upcomingMovies = result.results
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        print("Error invalidURL")
                    case .unableToComplete:
                        print("Error unableToComplete")
                    case .invalidResponse:
                        print("Error invalidResponse")
                    case .invalidData:
                        print("Error invalidData")
                    case .decodingError:
                        print("Error decodingError")
                    }
                }
            }
        }
    }
    
    func getMoviesNowPlaying() {
        NetworkManager.shared.getMoviesNowPlaying { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.nowPlayingMovies = movies
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        print("Error invalidURL")
                    case .unableToComplete:
                        print("Error unableToComplete")
                    case .invalidResponse:
                        print("Error invalidResponse")
                    case .invalidData:
                        print("Error invalidData")
                    case .decodingError:
                        print("Error decodingError")
                    }
                }
            }
        }
    }
    
    func getMoviesTrending() {
        NetworkManager.shared.getMoviesTrending() { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                switch result {
                case .success(let movies):
                    self.trendingMovies = movies
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        // self.alertItem = AlertContext.invalidURL
                        print("Error")
                        
                    case .decodingError:
                        // self.alertItem = AlertContext.decodingError
                        print("Error")
                    case .invalidData:
                        // self.alertItem = AlertContext.invalidData
                        print("Error")
                    case .invalidResponse:
                        // self.alertItem = AlertContext.invalidResponse
                        print("Error")
                    case .unableToComplete:
                        // self.alertItem = AlertContext.unableToComplete
                        print("Error")
                    }
                }
            }
        }
    }
    
    @MainActor
    func fetchNextSetOfMovies() async {
        guard page != totalPages else { return }
        
        viewState = .fetching
        defer { viewState = .finished }
        
        page += 1
        
        NetworkManager.shared.getLisOfUpcomingMovies(numPage: page) { [weak self] result in
            DispatchQueue.main.async {
                
                guard let self else { return }
                switch result {
                case .success(let result):
                    self.upcomingMovies.append(contentsOf: result.results)
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        print("Error invalidURL")
                    case .unableToComplete:
                        print("Error unableToComplete")
                    case .invalidResponse:
                        print("Error invalidResponse")
                    case .invalidData:
                        print("Error invalidData")
                    case .decodingError:
                        print("Error decodingError")
                    }
                }
            }
        }

    }
    
    func hasReachedEnd(of movie: DataMovie) -> Bool {
        upcomingMovies.last?.id == movie.id
    }
}

extension MoviesViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}
