//
//  MovieListScreenViewController.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import UIKit
import SnapKit

class MovieListScreenViewController: UIViewController {
    
    var presenter: MovieListScreenViewToPresenterProtocol?
    
    //Initialized Outlet
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    //Initialized Property
    var movieList: [MovieData] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = presenter?.getTitle()
        presenter?.viewDidLoad()
        configureMovieCollectionView()
    }
    
    //Initialized Action
    @IBAction func onActionButtonClicked(_ sender: UIButton) {
        presenter?.onBackButtonClicked()
    }
    
    //Initialized Method
    private func configureMovieCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.registerCell(MovieCollectionViewCell.self)
        movieCollectionView.collectionViewLayout = movieCollectionViewCompositionalLayout()
    }
    
    private func createFooterView() -> UIView {
        let containerView = UIView(
            frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.center = containerView.center
        containerView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        return containerView
    }
    
}

// MARK: - Presenter -> View
extension MovieListScreenViewController: MovieListScreenPresenterToViewProtocol {
    
    func showPagingLoadingView(_ isLoading: Bool) {
        if isLoading {
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.isHidden = true
            activityIndicatorView.stopAnimating()
        }
    }
    
    func showLoading(_ isLoading: Bool) {
        self.displayLoading(isLoading)
    }
    
    func showToatMessage(_ message: String) {
        self.view.makeToast(message, duration: 3.0, position: .bottom)
    }
    
}

// MARK: - Movie Collection View Delegate
extension MovieListScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if ConnectionService.isConnectedToNetwork() {
            presenter?.onMovieItemClicked(movieList[indexPath.item].id)
            return
        }
        showToatMessage(Message.NO_CONNECTION_MESSAGE)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(MovieCollectionViewCell.self, for: indexPath)
        
        cell.movieImage.image = UIImage(named: ImageConstant.DUMMY_IMAGE)
        cell.setData(movieList[indexPath.item])
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height - 100 {
            presenter?.onLoadMoreMovies()
        } else {
            showPagingLoadingView(false)
        }
    }
}
