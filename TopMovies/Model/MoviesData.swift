//
//  MoviesData.swift
//  TopMovies
//
//  Created by zombewmew on 15.01.2020.
//  Copyright © 2020 Christina S. All rights reserved.
//

import Foundation

struct MoviesData: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let release_date: String
    let vote_average: Double
}
