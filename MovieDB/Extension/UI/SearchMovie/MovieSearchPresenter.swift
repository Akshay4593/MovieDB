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
        moviesResult.removeAll()
        moviesResult.append(contentsOf: movies.filter { $0.title.lowercased().contains(searchText.lowercased()) })
        view?.showSearchResult(movies: moviesResult)
        if moviesResult.count == 0 {
            
            //Image.icEmptyState.image
            
            view?.showErrorView(type: .Custom(title: nil, desc: "No matching results found", image: Image.icEmptyState.image , btnAction: nil))
        } else {
            view?.hideErrorView()
        }
    }
    
    func didSeletMovie(indexPath: IndexPath) {
        let movie = moviesResult[indexPath.row]
        let index = movies.firstIndex(where: { $0.id == movie.id })
        let originalIndexPath = IndexPath(row: index ?? indexPath.row, section: 0)
        delegate?.movieSeachVC(tappedMovie: originalIndexPath)
        wireFrame?.dismiss(view: view!)
    }
    
    
}

extension MovieSearchPresenter: MovieSearchOutputInteractorProtocol {
    
}
