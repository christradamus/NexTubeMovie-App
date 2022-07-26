//
//  Constants.swift
//  theMoviesApp
//
//  Created by Valeria Muñoz toro on 25-07-22.
//

import Foundation

struct Constants{
    static let apiKey = "?api_key=c91b53d6b28e6f805f3e275e120c392f"
    
    struct URL {
        static let main = "https://api.themoviedb.org/"
        static let urlImages = "https://image.tmdb.org/t/p/w200"
    }
    
    struct Endpoints {
        static let urlListPopularMovies = "3/movie/popular"
        static let urlDetailMovie = "3/movie/"
    }
}
