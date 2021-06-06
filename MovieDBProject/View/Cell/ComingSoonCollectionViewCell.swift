//
//  ComingSoonCollectionViewCell.swift
//  MovieDBProject
//
//  Created by MacBook on 07/06/21.
//

import UIKit

class ComingSoonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var comingSoonImageView: UIImageView!
    
    func configure(imageURL: String){
        
        // Load Image
        ImageUtils.loadImage(urlString: imageURL) { (urlString, image) in
            
            // Caching image data
            ImageUtils.cacheImage(urlString: urlString, img: image!)
            
            self.comingSoonImageView.image = image
        }
    }
}
