//
//  MovieDetailUseCase.swift
//  moovies
//
//  Created by Sendo Tjiam on 23/03/22.
//

import Foundation
import Alamofire

struct MovieDetailUseCase : MovieDetailNetworkProvider {
    
    typealias GetMovieDetail = ((MovieDetail?, Error?) -> Void)
    
    func getMovieDetail(movieId: Int, completion: @escaping GetMovieDetail) {
        let url = "\(Constant.baseUrl)/movie/\(movieId)?api_key=\(Constant.apiKey)"
        print(url)
        AF.request(url).response { response in
            do {
                if let data = response.data {
                    let movie = try? JSONDecoder().decode(MovieDetail.self, from: data)
                    completion(movie, nil)
                }
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
