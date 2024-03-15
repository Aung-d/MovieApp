//
//  MoviesListScreenViewController.swift
//  MoviesViwer
//
//  Created by Winter on 3/13/24.
//

import UIKit
import CoreData

class HomeScreenViewController: UIViewController {
    
    var presenter: HomeScreenViewToPresenterProtocol?
    
    //Initialized Outlet
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UISearchView!
    
    //Initialized Property
    private let refreshControl = UIRefreshControl()
    
    var collectionViewHeaders: [String] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    var nowPlayingMovieData: [MovieData] = [] {
        didSet {
            if !ConnectionService.isConnectedToNetwork() {
                movieCollectionView.isHidden = nowPlayingMovieData.isEmpty
            }
            movieCollectionView.reloadData()
        }
    }
    var popularMovieData: [MovieData] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    var topRatedMovieData: [MovieData] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    var upcomingMovieData: [MovieData] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    var isSearchViewMode: Bool = false {
        didSet {
            movieCollectionView.collectionViewLayout = movieCollectionViewLayout()
            movieCollectionView.reloadData()
            if !isSearchViewMode {
                searchMovieData = []
                movieCollectionView.setContentOffset(
                    CGPoint(x:0,y:0), animated: true)
            }
        }
    }
    var searchMovieData: [MovieData] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.searchDelegate = self
        presenter?.viewDidLoad()
        configureMovieCollectionView()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        movieCollectionView.addSubview(refreshControl)
    }
    
    
    //Initialized Action
    
    //Initialized Method
   @objc private func onRefresh(send: UIRefreshControl) {
       presenter?.onRefreshData()
       self.refreshControl.endRefreshing()
    }
    
    private func configureMovieCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.registerCell(MovieCollectionViewCell.self)
        movieCollectionView.registerSupplementaryCell(MovieHeaderCollectionViewCell.self)
        movieCollectionView.collectionViewLayout = movieCollectionViewLayout()
    }
    
    private func movieCollectionViewLayout()  -> UICollectionViewCompositionalLayout {
        
        if isSearchViewMode {
           return movieCollectionViewCompositionalLayout()
        }
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(110),
            heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.interItemSpacing = .flexible(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [headerSupplementary]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 8
        layout.configuration = config
        return layout
    }
    
}


// MARK: - Presenter -> View
extension HomeScreenViewController: HomeScreenPresenterToViewProtocol {
    
    func showLoading(_ isLoading: Bool) {
        self.displayLoading(isLoading)
        
        if  !isLoading && !nowPlayingMovieData.isEmpty || !popularMovieData.isEmpty || !topRatedMovieData.isEmpty || !upcomingMovieData.isEmpty || !searchMovieData.isEmpty {
            movieCollectionView.isHidden = false
        }
    }
    
    func showToatMessage(_ message: String) {
        self.view.makeToast(message, duration: 3.0, position: .bottom)
    }
    
}

// MARK: - Movie Collection View Delegate
extension HomeScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, MovieHeaderCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieId = switch collectionViewHeaders[indexPath.section] {
        case MovieHeader.NOW_PLAYING:
            nowPlayingMovieData[indexPath.item].id
            
        case MovieHeader.POPULAR:
            popularMovieData[indexPath.item].id
            
        case MovieHeader.TOP_RATE:
            topRatedMovieData[indexPath.item].id
            
        default: upcomingMovieData[indexPath.item].id
        }
        
        if ConnectionService.isConnectedToNetwork() {
            presenter?.onMovieItemClicked(movieId)
            return
        }
        showToatMessage(Message.NO_CONNECTION_MESSAGE)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return isSearchViewMode ? searchMovieData.count : collectionViewHeaders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchViewMode {
            return searchMovieData.count
        }
        return switch collectionViewHeaders[section] {
        case MovieHeader.NOW_PLAYING:
            nowPlayingMovieData.count
            
        case MovieHeader.POPULAR:
            popularMovieData.count
            
        case MovieHeader.TOP_RATE:
            topRatedMovieData.count
            
        default: upcomingMovieData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(MovieCollectionViewCell.self, for: indexPath)
        
        cell.movieImage.image = UIImage(named: ImageConstant.DUMMY_IMAGE)
        
        if isSearchViewMode {
            cell.setData(searchMovieData[indexPath.item])
            return cell
        }
        
        switch collectionViewHeaders[indexPath.section] {
        case MovieHeader.NOW_PLAYING:
            cell.setData(nowPlayingMovieData[indexPath.item])
            
        case MovieHeader.POPULAR:
            cell.setData(popularMovieData[indexPath.item])
            
        case MovieHeader.TOP_RATE:
            cell.setData(topRatedMovieData[indexPath.item])
            
        default: cell.setData(upcomingMovieData[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerCell = collectionView.dequeueSupplementaryCell(
                kind, MovieHeaderCollectionViewCell.self, for: indexPath)
            
            headerCell.setData(collectionViewHeaders[indexPath.section])
            headerCell.delegate = self
            return headerCell
        }
        return UICollectionReusableView()
    }
    
    func onViewAllButtonClicked(_ title: String) {
        if ConnectionService.isConnectedToNetwork() {
            presenter?.onCollectionViewHeaderButtonClicked(title)
            return
        }
        showToatMessage(Message.NO_CONNECTION_MESSAGE)
    }
}

// MARK: - SearchView Delegate
extension HomeScreenViewController: SearchViewDelegate {
    
    func didSearchButtonClicked(_ text: String) {
        searchView.resignFirstResponder()
        presenter?.onSearchButtonClicked(text)
    }
    
    func didEnterSearch() {
        isSearchViewMode = true
    }
    
    func didCancelSearch() {
        isSearchViewMode = false
    }
}
