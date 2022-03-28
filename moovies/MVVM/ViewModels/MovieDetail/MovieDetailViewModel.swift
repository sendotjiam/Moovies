//
//  MovieDetail.swift
//  moovies
//
//  Created by Sendo Tjiam on 23/03/22.
//

import Foundation
import UIKit

class MovieDetailViewModel {
    // MARK: - Properties
    let useCase : MovieDetailUseCase
    var movieDetail : MovieDetail!
    
    init(useCase : MovieDetailUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Input
    var didReceiveMovieDetail : (() -> Void)?
    var didReceiveError : ((String) -> Void)?
    
    // MARK: - Output
    func getMovieDetail(movieId : Int) {
        useCase.getMovieDetail(movieId: movieId) { [weak self] movie, error in
            if error != nil {
                self?.didReceiveError?(error?.localizedDescription ?? "")
            }
            if let movie = movie {
                self?.movieDetail = movie
                self?.didReceiveMovieDetail?()
            }
        }
    }
    
}
