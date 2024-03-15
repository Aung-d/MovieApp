//
//  MovieHeaderCollectionViewCell.swift
//  MovieApp
//
//  Created by Winter on 3/14/24.
//

import UIKit


protocol MovieHeaderCollectionViewDelegate {
    func onViewAllButtonClicked(_ title: String)
}

class MovieHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    
    var delegate: MovieHeaderCollectionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(_ title: String) {
        headerLabel.text = title
    }

    @IBAction func onViewAllButtonClicked(_ sender: UIButton) {
        delegate?.onViewAllButtonClicked(headerLabel.text ?? "")
    }
}
