//
//  MovieSearchWireframe.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import UIKit

class MovieSearchWireFrame: MovieSearchWireFrameProtocol {
    
    func pushMovieDetailVC(view: MovieSearchVCProtocol, movie: Movie) {
        if let superVC = view as? UIViewController {
            let vc = AppNavigationCordinator.shared.createMovieDetailsModule(movieDetails: movie)
            superVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    func dismiss(view: MovieSearchVCProtocol) {
        if let vc = view as? UIViewController {
            vc.dismiss(animated: true, completion: nil)
        }
    }
 
}
