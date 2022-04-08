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
    var searchedMovies : Movies!
    
    init(useCase : MovieListUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var didReceivePopularMovies : (() -> Void)?
    var didReceiveError : ((String) -> Void)?
    var didSearchedMovies : (() -> Void)?
    
    // MARK: - Input
    func getPopularMovies(page: Int) {
        useCase.getPopularMovies(page: page) { [weak self] movies, error in
            guard let movies = movies,
                  error == nil
            else {
                self?.didReceiveError?(error?.localizedDescription ?? "")
                return
            }
            self?.moviesResult = movies
            self?.didReceivePopularMovies?()
        }
    }
    
    func searchMovies(keyword: String) {
        useCase.searchMovie(keyword: keyword) { [weak self] movies, error in
            guard let movies = movies,
                  error == nil
            else {
                print(error, ">>>")
                self?.didReceiveError?(error?.localizedDescription ?? "")
                return
            }
            print(movies)
            self?.searchedMovies = movies
            self?.didSearchedMovies?()
        }
    }
}
