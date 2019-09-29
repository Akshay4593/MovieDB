//
//  MovieCVCell.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        
        titleLbl.numberOfLines = 2
        titleLbl.font = UIFont.themeBoldFont(of: 18)
        titleLbl.textColor = UIColor.white
        imgView.image = nil
        self.contentView.backgroundColor = UIColor.lightText
        
        layerView.backgroundColor = UIColor.purple.withAlphaComponent(0.12)
        
        layerView.bringSubviewToFront(imgView)
        
    }
    
    override func prepareForReuse() {
        titleLbl.text = nil
        imgView.image = nil
    }
    
    public func configure(movie: Movie) {
        titleLbl.text = movie.title
        //imgView.kf.setImage(with: URL(fileURLWithPath:movie.fullPosterPath))
        
        let imgUrl = URL(string: movie.fullPosterPath)
        imgView.kf.setImage(with: imgUrl)
    
    }
    
}
