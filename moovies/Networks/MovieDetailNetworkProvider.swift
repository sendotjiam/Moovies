//
//  MovieDetailNetworkProvider.swift
//  moovies
//
//  Created by Sendo Tjiam on 23/03/22.
//

import Foundation

protocol MovieDetailNetworkProvider {
    func getMovieDetail(movieId : Int, completion: @escaping ((MovieDetail?, Error?) -> Void))
}
