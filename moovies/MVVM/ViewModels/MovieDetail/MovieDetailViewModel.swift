//
//  MovieDetail.swift
//  moovies
//
//  Created by Sendo Tjiam on 23/03/22.
//

import Foundation
import UIKit
import XCTest

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
    
    func deleteMovieDetail() {
        movieDetail = nil
    }
    
}


class MovieDetailViewModel: XCTests {
    
    func testGetMovieDetailTestPositive() {
        let movieDetail = MovieDetail()
        let mockUseCase = MockMovieDetailUseCase()
        mockUseCase.movie = movieDetail
        
        let sut = MovieDetailViewModel(useCase: mockUseCase)
        
        let expected = expectation(description: "didReceiveMovieDetail need to be called.")
        sut.didReceiveMovieDetail = {
            XCTAssetEqual(sut.movieDetail, movieDetail)
            expected.fulfill()
        }
        
        sut.getMovieDetail(movieId: 123)
        wait(for: [expected], timeout: .short)
    }

    func testGetMovieDetailTestNegative() {
        let movieDetail = MovieDetail()
        let mockUseCase = MockMovieDetailUseCase()
        mockUseCase.error = movieDetail
        
        let sut = MovieDetailViewModel(useCase: mockUseCase)
        
        let expected = expectation(description: "didReceiveError need to be called.")
        sut.didReceiveError = {
            XCTAssertNil(sut.movieDetail)
            expected.fulfill()
        }
        sut.getMovieDetail(movieId: 123)
        wait(for: [expected], timeout: .short)
    }

    
    func testDeleteMovieDetail() {
        let sut = MovieDetailViewModel(useCase: MockMovieDetailUseCase())
        sut.deleteMovieDetail()
        
        XCAssertNil(sut.movieDetail)
    }
}

struct MockMovieDetailUseCase: MovieDetailNetworkProvider {
    var movie: MovieDetail?
    var error: Error?
    func getMovieDetail(movieId : Int, completion: @escaping ((MovieDetail?, Error?) -> Void)) {
        completion(movie, error)
    }
}
