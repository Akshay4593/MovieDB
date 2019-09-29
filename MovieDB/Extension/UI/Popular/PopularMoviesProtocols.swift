//
//  PopularMoviesProtocols.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

protocol PopularMoviesWireFrameProtocol: class {
    func pushMovieDetailVC(view: PopularMoviesVCProtocol, movie: Movie)
}

protocol PopularMoviesVCProtocol : BaseView {
    var presenter: PopularMoviesPresenterProtocol? { get set }
    
    func showPopularMovies(viewModel: MovieViewModel)
    func insertPopularMovies(at indexPaths: [IndexPath])
    func reloadPopularMovies(at indexPaths: [IndexPath])
}

protocol PopularMoviesPresenterProtocol : BasePresenter {
    var view: PopularMoviesVCProtocol? { get set }
    var interactor: PopularMoviesInputInteractorProtocol? { get set }
    var wireFrame: PopularMoviesWireFrameProtocol? { get set }
    
    func retryLoadPopularMovies()
    func sortByPopularity()
    func sortByRatings()
    func willDisplayCell(at indexPath: IndexPath)
    func didSeletMovie(at indexPath: IndexPath)

}

protocol PopularMoviesInputInteractorProtocol: class {
    var presenter: PopularMoviesOutputInteractorProtocol? { get set }
    
    func makePopularMoviesRequest(page: Int)

}

protocol PopularMoviesOutputInteractorProtocol: class {
    func onPopularMoviesSuccess(response: PopularMoviesResponse)
    func onPopularMoviesError(error: APIError)
}
