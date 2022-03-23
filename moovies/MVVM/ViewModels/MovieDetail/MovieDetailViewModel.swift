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
    var didReceiveError : ((Error) -> Void)?
    
    // MARK: - Output
    func getMovieDetail(movieId : Int) {
        useCase.getMovieDetail(movieId: movieId) { [weak self] data, error in
            print(data, "<<< DATA")
        }
    }
    
}
