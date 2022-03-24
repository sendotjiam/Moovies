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
    let release_date : String
    let title : String
}
