//
//  MovieDetai.swift
//  moovies
//
//  Created by Sendo Tjiam on 23/03/22.
//

import Foundation

struct MovieDetail : Decodable {
    let id : Int
    let adult : Bool
    let poster_path : String //
    let original_language : String
    let overview : String //
    let popularity : Float
    let release_date : String //
    let title : String //
    let backdrop_path : String
    let homepage : String //
    let genres : [Genres]
    let tagline : String //
    let vote_average : Float // 
    let vote_count : Int,
    let budget : Int
}

struct Genres : Decodable {
    let id : Int
    let name : String
}
