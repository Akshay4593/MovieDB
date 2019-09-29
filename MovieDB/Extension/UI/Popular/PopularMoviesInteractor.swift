//
//  PopularMoviesInteractor.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

import Foundation

class PopularMoviesInteractor: PopularMoviesInputInteractorProtocol {
    
    weak var presenter: PopularMoviesOutputInteractorProtocol?
    
    init() {
    }
    
    func makePopularMoviesRequest(page: Int) {
        PopularMoviesRequest(page: page).response { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.presenter?.onPopularMoviesSuccess(response: response)
                break
            case .failure(let error):
                self?.presenter?.onPopularMoviesError(error: error)
                break
            }
        }
    }
    
}
