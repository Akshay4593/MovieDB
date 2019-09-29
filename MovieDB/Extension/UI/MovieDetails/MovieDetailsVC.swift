//
//  MovieDetailsVC.swift
//  MovieDB
//
//  Created by Akshay Shedge on 30/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailsVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var ratingsLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var movieDetails : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
    }
    
    private func setTheme(){
        movieTitleLbl.font = UIFont.themeBoldFont(of: 24)
        overviewLbl.font = UIFont.themeMediumFont(of: 20)
        descriptionLbl.font = UIFont.themeRegularFont(of: 16)

        ratingsLbl.font = UIFont.themeRegularFont(of: 15)
        imgView.backgroundColor = UIColor.purple.withAlphaComponent(0.12)

        releaseDateLbl.font = UIFont.themeRegularFont(of: 16)
        
        descriptionLbl.textColor = UIColor.darkText
        overviewLbl.textColor = UIColor.black
        
        releaseDateLbl.textColor = UIColor.darkText
        
        imgView.layer.cornerRadius = 8
        imgView.layer.masksToBounds = true

    }
    
    private func setData(){
        
        guard let movieDetails = movieDetails else {
            return
        }
        movieTitleLbl.text = movieDetails.originalTitle.capitalized
        ratingsLbl.text = "Ratings: \(movieDetails.voteAverage) (\(movieDetails.voteCount) Reviews)"

        releaseDateLbl.text = "Released date: \(movieDetails.releaseDate.formatDateMediumStyle(dateFormat: "yyyy-MM-dd"))"
        
        overviewLbl.text = "Overview"
        descriptionLbl.text = movieDetails.overview
        
        let imgUrl = URL(string: movieDetails.fullPosterPath)
        imgView.kf.setImage(with: imgUrl)
    }

}
