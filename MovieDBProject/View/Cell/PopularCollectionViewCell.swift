//
//  PopularCollectionViewCell.swift
//  MovieDBProject
//
//  Created by MacBook on 07/06/21.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(title: String, desc: String, imageURL: String){
        
        self.titleLabel.text = title
        self.descriptionLabel.text = desc
        
        // Load Image
        ImageUtils.loadImage(urlString: imageURL) { (urlString, image) in
            
            // Caching image data
            ImageUtils.cacheImage(urlString: urlString, img: image!)
            
            self.movieImageView.image = image
        }
    }
}
