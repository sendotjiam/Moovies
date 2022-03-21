//
//  Movies.swift
//  moovies
//
//  Created by Sendo Tjiam on 04/03/22.
//

import Foundation

struct Movies : Decodable {
    let page : Int
    let results : [Movie]
}

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
