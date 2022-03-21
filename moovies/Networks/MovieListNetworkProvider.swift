//
//  MovieListNetworkProvider.swift
//  moovies
//
//  Created by Sendo Tjiam on 04/03/22.
//

import Foundation

protocol MovieListNetworkProvider {
    func getPopularMovies(page: Int, completion: @escaping ((Movies?, Error?) -> Void))
}
