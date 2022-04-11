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
    typealias SearchMovie = ((Movies?, Error?) -> Void)
    
    private let decoder = JSONDecoder()
    
    func getPopularMovies(page: Int, completion: @escaping GetPopularMovies) {
        let url = "\(Constant.baseUrl)/movie/popular?api_key=\(Constant.apiKey)&page=\(page)"
        AF.request(url).response { response in
            do {
                guard let data = response.data else { return }
                let movies = try decoder.decode(Movies.self, from: data)
                completion(movies, nil)
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func searchMovie(keyword: String, completion: @escaping ((Movies?, Error?) -> Void)) {
        let url = "\(Constant.baseUrl)/search/movie?api_key=\(Constant.apiKey)&query=\(keyword)"
        print(url)
        AF.request(url).response { response in
            do {
                guard let data = response.data else { return }
                let movies = try decoder.decode(Movies.self, from: data)
                completion(movies, nil)
            } catch let error {
                print(error)
                completion(nil, error)
            }
        }
    }
}
