//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

class MovieViewModel: PaginationViewModel<Movie> {
    
    override init(pageSize: Int = 20) {
        super.init(pageSize: pageSize)
    }
    
    public func movie(at indexPath: IndexPath) -> Movie {
        return data[indexPath.row]
    }
    
    var moviesCount: Int {
        return data.count
    }
    
}
