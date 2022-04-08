//
//  MovieListViewModel.swift
//  moovies
//
//  Created by Sendo Tjiam on 04/03/22.
//

import Foundation

class MovieListViewModel {
    
    // MARK: - Properties
    let useCase : MovieListUseCase
    var moviesResult : Movies!
    
    init(useCase : MovieListUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var didReceivePopularMovies : (() -> Void)?
    var didReceiveError : ((String) -> Void)?
    var didSearchedMovie : (() -> Void)?
    
    // MARK: - Input
    func getPopularMovies(page: Int) {
        useCase.getPopularMovies(page: page) { [weak self] movies, error in
            if error != nil {
                self?.didReceiveError?(error?.localizedDescription ?? "")
            }
            if let movies = movies {
                self?.moviesResult = movies
                self?.didReceivePopularMovies?()
            }
        }
    }
    
    func searchMovies(keyword: String) {
        
    }
}
