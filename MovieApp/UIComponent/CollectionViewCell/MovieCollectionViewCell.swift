//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Winter on 3/13/24.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCell()
    }
    
    private func configureCell() {
        movieImage.layer.cornerRadius = 8
        movieName.layer.masksToBounds = true
    }
    
    func setData(_ movie: MovieData) {
        movieName.text = movie.title
        activityIndicatorView.startAnimating()
        if let url = URL(string: movie.getPosterPath()) {
            movieImage.kf.setImage(with: url) { [weak self] result in
                self?.activityIndicatorView.stopAnimating()
                
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    self?.movieImage.image = UIImage(named: ImageConstant.ERROR_IMAGE)
                }
            }
        }
    }

}
