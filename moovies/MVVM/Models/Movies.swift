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
