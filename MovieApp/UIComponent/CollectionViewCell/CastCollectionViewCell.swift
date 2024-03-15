//
//  CastCollectionViewCell.swift
//  MovieApp
//
//  Created by Winter on 3/15/24.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imageContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureView()
    }
    
    private func configureView() {
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageContainerView.layer.cornerRadius = imageView.frame.height / 2
        
    }
    
    func setData(cast: Cast) {
        activityIndicatorView.startAnimating()
        imageView.kf.setImage(with: URL(string: cast.getImagePath())) { [weak self] result in
            self?.activityIndicatorView.stopAnimating()
            switch result {
            case .success(_):
                break
            case .failure(_):
                self?.imageView.image = UIImage(named: ImageConstant.ERROR_IMAGE)
            }
        }
        nameLabel.text = cast.name
    }

}
