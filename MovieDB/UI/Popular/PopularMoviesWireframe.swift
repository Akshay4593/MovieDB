//
//  PopularMoviesWireframe.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import UIKit

class PopularMoviesWireFrame: PopularMoviesWireFrameProtocol {
    
    func pushMovieDetailVC(view: PopularMoviesVCProtocol, movie: Movie) {
        if let superVC = view as? UIViewController {
//            let vc = AppNavigationCordinator.shared.createMovieDetailModule(movie: movie)
//            superVC.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
}
