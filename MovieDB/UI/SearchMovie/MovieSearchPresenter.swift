//
//  MovieSearchPresenter.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import UIKit

class MovieSearchPresenter: MovieSearchPresenterProtocol {
    
    
    weak var view: MovieSearchVCProtocol?
    var interactor: MovieSearchInputInteractorProtocol?
    var wireFrame: MovieSearchWireFrameProtocol?
    private var movies: [Movie] = []
    private var moviesResult: [Movie] = []
    private weak var delegate: MovieSearchResultVCDelegate?
    
    init(delegate: MovieSearchResultVCDelegate?) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
    
    func setFilterMovies(movies: [Movie]) {
        self.movies.removeAll()
        self.moviesResult.removeAll()
        self.movies.append(contentsOf: movies)
        view?.showSearchResult(movies: moviesResult)
    }
    
    func searchMovie(searchText: String) {
          let movieName = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            interactor?.makeSearchMovieRequest(name: movieName)
    }
    
    func didSeletMovie(indexPath: IndexPath) {
        let movie = moviesResult[indexPath.row]
        delegate?.movieSeachVC(movie: movie)
        wireFrame?.dismiss(view: view!)
        
    }
    
    
}

extension MovieSearchPresenter: MovieSearchOutputInteractorProtocol {
    func onSearchMoviesSuccess(response: PopularMoviesResponse) {
        view?.hideLoading()
        moviesResult.removeAll()
        let movies = response.results
        moviesResult.append(contentsOf: movies)
         view?.showSearchResult(movies: moviesResult)
        if moviesResult.count == 0 {
            
            view?.showErrorView(type: .Custom(title: nil, desc: "No matching results found", image: Image.icEmptyState.image , btnAction: nil))
        } else {
            view?.hideErrorView()
        }
        
    }
    
    func onSearchMoviesError(error: APIError) {

        view?.hideLoading()
        view?.showErrorView(type: .Custom(title: nil, desc: error.description, image:Image.icEmptyState.image, btnAction: "Retry"))
    }
    
    
}
