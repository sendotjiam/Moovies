//
//  MovieListUseCase.swift
//  moovies
//
//  Created by Sendo Tjiam on 04/03/22.
//

import Foundation
import Alamofire

struct MovieListUseCase : MovieListNetworkProvider {
    
    typealias GetPopularMovies = ((Movies?, Error?) -> Void)
    
    func getPopularMovies(page: Int, completion: @escaping GetPopularMovies) {
        let url = "\(Constant.baseUrl)/movie/popular?api_key=\(Constant.apiKey)&page=\(page)"
        AF.request(url).response { response in
            do {
                let data = try? JSONDecoder().decode(Movies.self, from: response.data!)
                completion(data, nil)
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
