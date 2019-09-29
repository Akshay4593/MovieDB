//
//  MovieSearchProtocols.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

protocol MovieSearchWireFrameProtocol: class {
    func dismiss(view: MovieSearchVCProtocol)
}

protocol MovieSearchVCProtocol: BaseView {
    var presenter: MovieSearchPresenterProtocol? { get set }
    
    func showSearchResult(movies: [Movie])
}

protocol MovieSearchPresenterProtocol: BasePresenter {
    var view: MovieSearchVCProtocol? { get set }
    var interactor: MovieSearchInputInteractorProtocol? { get set }
    var wireFrame: MovieSearchWireFrameProtocol? { get set }
    
    func setFilterMovies(movies: [Movie])
    func searchMovie(searchText: String)
    func didSeletMovie(indexPath: IndexPath)
    
}

protocol MovieSearchInputInteractorProtocol: class {
    var presenter: MovieSearchOutputInteractorProtocol? { get set }
    
}

protocol MovieSearchOutputInteractorProtocol: class {
    
}
