//
//  MovieDetailUseCase.swift
//  moovies
//
//  Created by Sendo Tjiam on 23/03/22.
//

import Foundation
import Alamofire

protocol ApiClient {
//    func makeRequest(_ request: URLRequest, completion: @escaping (_ response: URLResponse?, _ data: Data?, _ error: Error?) -> Void)
    func request(_ path: String, completion: @escaping (_ response: URLResponse?, _ data: Data?, _ error: Error?) -> Void)
}

class AFApiClient: ApiClient {
    func request(_ path: String, completion: @escaping (_ response: URLResponse?, _ data: Data?, _ error: Error?) -> Void) {
        let url = "\(Constant.baseUrl)/\(path)?api_key=\(Constant.apiKey)"
        AF.request(url).response { response in
            let httpResponse = response.response
            completion(httpResponse, response.data, response.error)
        }
    }
}

enum MovieDetailError: Error {
    case ApiError
}

struct MovieDetailUseCase : MovieDetailNetworkProvider {
    
    typealias GetMovieDetail = ((MovieDetail?, Error?) -> Void)
    
    private let apiClient: ApiClient
    
    init(_ apiClient: ApiClient = AFApiClient()) {
        self.apiClient = apiClient
    }
    
    func getMovieDetail(movieId: Int, completion: @escaping GetMovieDetail) {
        let url = "\(Constant.baseUrl)/movie/\(movieId)?api_key=\(Constant.apiKey)"
        print(url)
        apiClient.request(
            "movie/\(movieId)",
            completion: { response, data, error in
                guard let data = data, let movie = try? JSONDecoder().decode(MovieDetail.self, from: data) else {
                    completion(nil, MovieDetailError.ApiError)
                    return
                }
                completion(movie, nil)
            }
        )
    
        
        
//        AF.request(url).response { response in
//            do {
//                if let data = response.data {
//                    let movie = try? JSONDecoder().decode(MovieDetail.self, from: data)
//                    completion(movie, nil)
//                }
//            } catch let error {
//                print(error.localizedDescription)
//                completion(nil, error)
//            }
//        }
    }
}




import XCTest

class MovieDetailUseCaseTests: XCTestCase {

    func testGetMovieDetailSuccess() {

        // Given
        let movieDetail = MovieDetail()

        let mock = MockApiClient()
        mock.data = "{'data': { 'name': 'Movile'}}".data(using: .utf8)
        let sut = MovieDetailUseCase(mock)

        // When
        let expected = expectation(description: "callback happened")
        sut.getMovieDetail(movieId: 123) { detail, error in
            
            // Then
            XCTAssertEqual(detail, movieDetail)

            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }

    func testGetMobieDetailFailure() {
        // Given
        let movieDetail = MovieDetail()

        let mock = MockApiClient()
        mock.error = MovieDetailError.ApiError
        let sut = MovieDetailUseCase(mock)

        // When
        let expected = expectation(description: "callback happened")
        sut.getMovieDetail(movieId: 123) { detail, error in
            
            // Then
            XCTAssertEqual(error, MovieDetailError.ApiError)

            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
        
    }
    
}

class MockApiClient: ApiClient {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    func request(_ path: String, completion: @escaping (_ response: URLResponse?, _ data: Data?, _ error: Error?) -> Void) {
        completion(URLResponse(), data, error)
    }
}
