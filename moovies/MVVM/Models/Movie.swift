//
//  Movie.swift
//  moovies
//
//  Created by Sendo Tjiam on 24/03/22.
//

import Foundation

struct Movie : Decodable {
    let id : Int
    let adult : Bool
    let poster_path : String
    let original_language : String
    let overview : String
    let popularity : Float
    let release_date : String?
    let title : String
    
//    func toJsonDictionary() -> [String: Any] {
//        var dict : [String : Any] = [:]
//        dict["id"] = id ?? 0
//        dict["adult"] = adult ?? false
//        dict["poster_path"] = poster_path ?? ""
//        dict["original_language"] = original_language ?? "english"
//        dict["overview"] = overview ?? "Nothing to be describe"
//        dict["popularity"] = popularity ?? 0.0
//        dict["release_date"] = release_date ?? "-"
//        dict["title"] = title ?? "Unknown"
//        return dict
//    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case adult = "adult"
        case poster_path = "poster_path"
        case original_language = "original_language"
        case overview = "overview"
        case popularity = "popularity"
        case release_date = "release_date"
        case title = "title"
    }
}
