//
//  MovieRoute.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

enum MovieRoute {
    case popularMovies
    case searchMovies
}

extension MovieRoute {
    
    private var baseUrl: String {
        return Constant.MOVIE_DB_BASE_PATH
    }
    
    private var apiEndPoint: String {
        return "\(baseUrl)/\(urlPath)?api_key=\(Constant.API_KEY)"
    }
    
    private var urlPath: String {
        switch self {
        case .popularMovies:
            return "movie/popular"
        case .searchMovies:
            return "search/movie"
        }
    }
    
    var url: URL {
        return URL(string: apiEndPoint)!
    }
    
    var asRoute: Route {
        switch self {
        case .popularMovies:
            return Route.getRoute(path: apiEndPoint)
        case .searchMovies:
            return Route.getRoute(path: apiEndPoint)
        }
    }
    
}
