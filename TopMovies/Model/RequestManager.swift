//
//  RequestManager.swift
//  TopMovies
//
//  Created by zombewmew on 14.01.2020.
//  Copyright © 2020 Christina S. All rights reserved.
//

import Foundation

protocol RequestManagerDelegate {
    func didUpdateMovies(_: RequestManager, movies: [MoviesModel])
    func didFailWithError(error: Error)
}

struct RequestManager {
    let weatherURL = "https://api.themoviedb.org/3/discover/movie?api_key=52c6a0cf5e1ddfee26daf794e31ad7ee&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=2019"
    
    var delegate: RequestManagerDelegate?
    
    func fetchMovies() {
        let urlString = "\(weatherURL)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
                
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
        
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let movies = self.parseJson(safeData) {
                        self.delegate?.didUpdateMovies(self, movies: movies as! [MoviesModel])
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ moviesData: Data) -> [MoviesModel?]? {
        var moviesResult: [MoviesModel?] = []
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(MoviesData.self, from: moviesData)
            
            for itemMovie in decodeData.results {
                let movie = MoviesModel(id: itemMovie.id, name: itemMovie.title, description: itemMovie.overview, score: itemMovie.vote_average, posterUrl: itemMovie.poster_path, date: itemMovie.release_date)
                moviesResult.append(movie)
            }
            
            return moviesResult

        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }

    }
    
}
