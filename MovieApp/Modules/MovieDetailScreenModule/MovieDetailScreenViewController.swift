//
//  MovieDetailScreenViewController.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import UIKit
import Kingfisher

class MovieDetailScreenViewController: UIViewController {
    
    var presenter: MovieDetailScreenViewToPresenterProtocol?
    
    //Initialized Outlet
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var moviesTitleLabel: UILabel!
    @IBOutlet weak var moviesInfoLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var playTrailerButton: UIButton!
    
    //Initialized Property
    var movieDetail: MovieDetailResponse? {
        didSet {
            if let safeMovie = movieDetail {
                activityIndicatorView.startAnimating()
                movieImage.kf.setImage(with: URL(string: safeMovie.getBackdropPath())) { [weak self] result in
                    self?.activityIndicatorView.stopAnimating()
                    switch result {
                    case .success(_):
                        break
                    case .failure(_):
                        self?.movieImage.image = UIImage(named: ImageConstant.ERROR_IMAGE)
                    }
                }
                
                ratingLabel.text = "TMDB \(String(format: "%.1f", safeMovie.voteAverage))"
                moviesTitleLabel.text = safeMovie.title
                
                let (hour, minutes) = convertMinutesToHoursAndMinutes(safeMovie.runtime)
                moviesInfoLabel.text =
                "\(safeMovie.releaseDate.prefix(4)) • \(hour)h \(minutes)m • \(safeMovie.spokenLanguages.first?.name ?? "English")"
                
                var genres = ""
                for (index, genre) in safeMovie.genres.enumerated() {
                    if index == safeMovie.genres.count - 1 {
                        genres += "\(genre.name)"
                        break
                    }
                    genres += "\(genre.name) • "
                }
                genreLabel.text = genres
                overViewLabel.text = safeMovie.overview
            }
        }
    }
    
    var casts: [Cast] = [] {
        didSet {
            castCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingView.layer.cornerRadius = 8
        ratingView.layer.masksToBounds = true
        playTrailerButton.layer.cornerRadius = playTrailerButton.frame.height / 2
        presenter?.viewDidLoad()
        configureCollectionView()
    }
    
    
    //Initialized Action
    @IBAction func onActionButtonClicked(_ sender: UIButton) {
        switch MovieDetailScreenButtonTag(rawValue: sender.tag) {
        case .BACK_BUTTON:
            presenter?.onBackButtonClicked()
            
        case .PLAY_TRAILER_BUTTON:
            if ConnectionService.isConnectedToNetwork() {
                presenter?.onPlayButtonClicked()
            } else {
                showToatMessage(Message.NO_CONNECTION_MESSAGE)
            }
            
        default: return
        }
    }
    
    //Initialized Method
    private func configureCollectionView() {
        castCollectionView.layer.cornerRadius = 12
        castCollectionView.layer.masksToBounds = true
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.registerCell(CastCollectionViewCell.self)
    }
    
    private func convertMinutesToHoursAndMinutes(_ minutes: Int) -> (hours: Int, minutes: Int) {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return (hours, remainingMinutes)
    }
    
}

// MARK: - Presenter -> View
extension MovieDetailScreenViewController: MovieDetailScreenPresenterToViewProtocol {
    
    func showLoading(_ isLoading: Bool) {
        self.displayLoading(isLoading)
    }
    
    func showToatMessage(_ message: String) {
        self.view.makeToast(message, duration: 3.0, position: .bottom)
    }
}


// MARK: - UICollectionViewDelegate
extension MovieDetailScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CastCollectionViewCell.self, for: indexPath)
        cell.setData(cast: casts[indexPath.item])
        return cell
    }
 
}
