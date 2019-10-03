//
//  SearchMovieRequest.swift
//  MovieDB
//
//  Created by Akshay Shedge on 30/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation


class SearchMovieRequest: APIRequest<PopularMoviesResponse> {
    
    private var page: Int = 1
    private var movieName: String = ""
    
    init(movieName: String) {
        self.movieName = movieName
        super.init(route: MovieRoute.searchMovies.asRoute)

    }
    
    override func getParameters() -> [String : Any] {
        return [
           "query": self.movieName
        ]
    }
    
}
