//
//  MovieSearchResultVC.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit

protocol MovieSearchResultVCDelegate: class {
    func movieSeachVC(tappedMovie index: IndexPath)
}

class MovieSearchResultVC: BaseUIViewController, UISearchBarDelegate {
    
    private var moviesResult: [Movie] = []
    private var searchBar: UISearchBar?
    var presenter: MovieSearchPresenterProtocol?
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - (3 * spacing)) / 2
        let itemHeight: CGFloat = itemWidth * (3/2)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(inset: spacing)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.register(UINib(nibName: "MovieCVCell", bundle: nil), forCellWithReuseIdentifier: "MovieCVCell")
        collectionView.backgroundColor = UIColor.white
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBar = searchBar
        presenter?.searchMovie(searchText: searchText)
    }
    
}

extension MovieSearchResultVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCell", for: indexPath) as! MovieCVCell
        let movie = moviesResult[indexPath.row]
        cell.configure(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _searchBar = searchBar {
            _searchBar.text = ""
            _searchBar.resignFirstResponder()
        }
        presenter?.didSeletMovie(indexPath: indexPath)
    }
    
}

extension MovieSearchResultVC: MovieSearchVCProtocol {
    
    func showSearchResult(movies: [Movie]) {
        moviesResult.removeAll()
        moviesResult.append(contentsOf: movies)
        collectionView.reloadData()
    }
    
    func showErrorView(type: EmptyErrorType) {
        showError(type: type)
    }
    
}
