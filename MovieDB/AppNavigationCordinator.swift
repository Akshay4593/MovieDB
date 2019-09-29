//
//  AppNavigationCordinator.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import UIKit

class AppNavigationCordinator {
    
    static let shared: AppNavigationCordinator = AppNavigationCordinator()
    
    private init() {}
    
    func createPopularMoviesModule() -> UIViewController {
        let vc = UIStoryboard(name: "Popular", bundle: nil)
            .instantiateViewController(withIdentifier: "PopularMoviesVC") as! PopularMoviesVC
        
        let presenter: PopularMoviesPresenterProtocol & PopularMoviesOutputInteractorProtocol = PopularMoviesPresenter()
        let interactor: PopularMoviesInputInteractorProtocol = PopularMoviesInteractor()
        let wireFrame: PopularMoviesWireFrameProtocol = PopularMoviesWireFrame()
        
        vc.presenter = presenter
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        
        return vc
    }
    
    func createSearchMoviesModule(delegate: MovieSearchResultVCDelegate?) -> UIViewController {
        let vc = MovieSearchResultVC()
        
        let presenter: MovieSearchPresenterProtocol & MovieSearchOutputInteractorProtocol = MovieSearchPresenter(delegate: delegate)
        let interactor: MovieSearchInputInteractorProtocol = MovieSearchInteractor()
        let wireFrame: MovieSearchWireFrameProtocol = MovieSearchWireFrame()
        
        vc.presenter = presenter
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        
        return vc
    }
    
    func createMovieDetailsModule(movieDetails: Movie) -> UIViewController {
        let vc = UIStoryboard(name: "MovieDetails", bundle: nil)
            .instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        vc.movieDetails = movieDetails
        return vc
    }
    
}
