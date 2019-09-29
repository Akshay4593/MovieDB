//
//  PopularMoviesVC.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit

class PopularMoviesVC: BaseUIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let spacing: CGFloat = 16
    private let numberOfColumns: CGFloat = 2
    private var flowLayout: UICollectionViewFlowLayout!
    private var showCVLoadingFooter: Bool = false
    
    var presenter: PopularMoviesPresenterProtocol?
    private var movieViewModel: MovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    internal override func setUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.tintColor = UIColor.red
        spinner.startAnimating()
        
        collectionView.register(UINib(nibName: "MovieCVCell", bundle: nil), forCellWithReuseIdentifier: "MovieCVCell")
        collectionView.register(MovieLoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MovieLoadingFooter")
        
        flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout ?? UICollectionViewFlowLayout()
        
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.minimumLineSpacing = spacing
        flowLayout.sectionInset = UIEdgeInsets(inset: spacing)
        flowLayout.minimumInteritemSpacing = spacing
        
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - ((numberOfColumns + 1) * spacing))/numberOfColumns
        let itemHeight: CGFloat = itemWidth * (3/2)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let settingsBtn = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .plain, target: self, action: #selector(settingsBtnTapped))
        
        navigationItem.rightBarButtonItem = settingsBtn
        
        
        // Set SearchController
    
        let searchVC = AppNavigationCordinator.shared.createSearchMoviesModule(delegate: self)
        let searchController = UISearchController(searchResultsController: searchVC)
        if #available(iOS 11, *) {
            searchController.obscuresBackgroundDuringPresentation = true
        } else {
            searchController.dimsBackgroundDuringPresentation = true
        }
        definesPresentationContext = true
        searchController.searchResultsUpdater = nil
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = searchVC as? UISearchBarDelegate
        searchController.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        
        if #available(iOS 11, *) {
            navigationItem.searchController = searchController
            //navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.titleView = searchController.view
        }
        definesPresentationContext = true
    }
    
    @objc private func settingsBtnTapped() {
        showSortByActionbSheet()
    }
    
    private func showSortByActionbSheet() {
        let alert = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        
        let popularAction = UIAlertAction(title: "Most popular", style: .default) { (action) in
            self.presenter?.sortByPopularity()
        }
        
        let highestRatedAction = UIAlertAction(title: "Highest Rated", style: .default) { (action) in
            self.presenter?.sortByRatings()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(popularAction)
        alert.addAction(highestRatedAction)
        alert.addAction(cancelAction)
    
        self.present(alert, animated: true, completion: nil)
      
    }
    
    
    
}

extension PopularMoviesVC: UISearchControllerDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        guard let vc = searchController.searchResultsController as? MovieSearchResultVC, let _model = movieViewModel, let presenter = vc.presenter else {
            return
        }
        presenter.setFilterMovies(movies: _model.data)
    }
    
}

extension PopularMoviesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.movieViewModel else {
            return 0
        }
        return viewModel.moviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCell", for: indexPath) as! MovieCVCell
        guard let viewModel = self.movieViewModel else {
            return cell
        }
        let movie = viewModel.movie(at: indexPath)
        cell.configure(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if showCVLoadingFooter {
            return CGSize(width: UIScreen.main.bounds.width, height: 60)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if showCVLoadingFooter {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MovieLoadingFooter", for: indexPath) as! MovieLoadingFooterView
            return cell
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.willDisplayCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSeletMovie(at: indexPath)
    }
    
}

extension PopularMoviesVC: PopularMoviesVCProtocol {
    
    func showErrorView(type: EmptyErrorType) {
        self.showError(type: type, delegate: self)
    }
    
    func showLoading(message: String) {
        if movieViewModel == nil {
            showCVLoadingFooter = false
            showLoadingView(msg: message)
        } else {
            showCVLoadingFooter = true
            //collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func hideLoading() {
        if showCVLoadingFooter {
            showCVLoadingFooter = false
            // collectionView.reloadSections(IndexSet(integer: 0))
        } else {
            hideLoadingView()
        }
    }
    
    func showPopularMovies(viewModel: MovieViewModel) {
        self.movieViewModel = viewModel
        collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func insertPopularMovies(at indexPaths: [IndexPath]) {
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: indexPaths)
        }, completion: nil)
        collectionView.reloadItems(at: indexPaths)
        
    }
    
    func reloadPopularMovies(at indexPaths: [IndexPath]) {
        if indexPaths.isEmpty {
            let index = collectionView.indexPathsForVisibleItems
            collectionView.reloadItems(at: index)
        } else {
            collectionView.reloadItems(at: indexPaths)
        }
    }
    
}

extension PopularMoviesVC: SNEmptyStateViewDelegate {
    
    func retryBtnTapped() {
        presenter?.retryLoadPopularMovies()
    }
    
}

extension PopularMoviesVC: MovieSearchResultVCDelegate {
    
    func movieSeachVC(tappedMovie index: IndexPath) {
        presenter?.didSeletMovie(at: index)
    }
    
}
