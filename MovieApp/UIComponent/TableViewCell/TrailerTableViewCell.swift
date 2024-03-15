//
//  TrailerTableViewCell.swift
//  MovieApp
//
//  Created by Winter on 3/15/24.
//

import UIKit

class TrailerTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImage.layer.cornerRadius = 8
        posterImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if isSelected {
            contentView.backgroundColor = UIColor(named: "ContainerBackgroundColor")
        } else {
            contentView.backgroundColor = UIColor.clear
        }
    }
    
    func setData(_ info: VideoInfo, posterPath: String) {
        
        titleLabel.text = info.name
        dateLabel.text = "Date - \(info.publishedAt.prefix(10))"
        
        if let url = URL(string: posterPath) {
            activityIndicatorView.startAnimating()
            posterImage.kf.setImage(with: url) { [weak self] result in
                self?.activityIndicatorView.stopAnimating()
                
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    self?.posterImage.image = UIImage(named: ImageConstant.ERROR_IMAGE)
                }
            }
        }
    }
    
}
