//
//  PopularMoviesPresenter.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import UIKit

class PopularMoviesPresenter: PopularMoviesPresenterProtocol {

    
    weak var view: PopularMoviesVCProtocol?
    var interactor: PopularMoviesInputInteractorProtocol?
    var wireFrame: PopularMoviesWireFrameProtocol?
    
    private var moviesViewModel: MovieViewModel = MovieViewModel(pageSize: 20)
    private var lastSelectedIndexPath: IndexPath?
    
    func willDisplayCell(at indexPath: IndexPath) {
        if moviesViewModel.canLoadNow(index: indexPath.row) {
            loadPopularMovies()
        }
    }
    
    func viewDidLoad() {
        loadPopularMovies()
    }
    
    func viewWillAppear() {
        if let indexPath = lastSelectedIndexPath {
            view?.reloadPopularMovies(at: [indexPath])
            lastSelectedIndexPath = nil
        }
            view?.reloadPopularMovies(at: [])
    }
    
    func retryLoadPopularMovies() {
        loadPopularMovies()
    }
    
    private func loadPopularMovies() {
        view?.showLoading(message: "Loading")
        if moviesViewModel.isLoading {
            return
        }
        moviesViewModel.start()
        interactor?.makePopularMoviesRequest(page: moviesViewModel.page)
    }
    
    func didSeletMovie(at indexPath: IndexPath) {
        let movie = moviesViewModel.movie(at: indexPath)
        lastSelectedIndexPath = indexPath
        wireFrame?.pushMovieDetailVC(view: view!, movie: movie)
    }
    
    func sortByPopularity() {
        
        
    }
    
    func sortByRatings() {
        var movieData = moviesViewModel.data
        movieData.sort { $0.voteAverage > $1.voteAverage }
        view?.showPopularMovies(viewModel: moviesViewModel)

    }
    

    
}

extension PopularMoviesPresenter: PopularMoviesOutputInteractorProtocol {
    
    func onPopularMoviesSuccess(response: PopularMoviesResponse) {
        view?.hideLoading()
        moviesViewModel.success(objects: response.results)
        if response.page == 1 {
            view?.showPopularMovies(viewModel: moviesViewModel)
        } else {
            let previousCount = moviesViewModel.moviesCount - response.results.count
            let totalCount = moviesViewModel.moviesCount
            let indexPaths: [IndexPath] = (previousCount..<totalCount).map {
                return IndexPath(item: $0, section: 0)
            }
            view?.insertPopularMovies(at: indexPaths)
        }
    }
    
    func onPopularMoviesError(error: APIError) {
        view?.hideLoading()
        moviesViewModel.failed()
        view?.showErrorView(type: .Custom(title: nil, desc: error.description, image: UIImage(), btnAction: "Retry"))
    }
    
}
