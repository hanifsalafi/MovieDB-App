//
//  PopularHomeCollectionViewCell.swift
//  MovieDBProject
//
//  Created by MacBook on 07/06/21.
//

import UIKit

class PopularHomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var popularImageView: UIImageView!
    
    func configure(imageURL: String){
        
        // Load Image
        ImageUtils.loadImage(urlString: imageURL) { (urlString, image) in
            
            // Caching image data
            ImageUtils.cacheImage(urlString: urlString, img: image!)
            
            self.popularImageView.image = image
        }
    }
    
}
