//
//  FavoriteTableViewCell.swift
//  MovieDBProject
//
//  Created by MacBook on 07/06/21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String?, year: String?, desc: String?, imageURL: String?){
        
        self.titleLabel.text = title ?? ""
        self.yearLabel.text = String(year?.prefix(4) ?? "")
        self.descLabel.text = desc ?? ""
        
        // Load Image
        if let imageUrl = imageURL {
            let url = CommonCons.pathURLImage+imageUrl
            ImageUtils.loadImage(urlString: url) { (urlString, image) in
                
                // Caching image data
                ImageUtils.cacheImage(urlString: urlString, img: image!)
                
                self.movieImageView.image = image
            }
        }
    }

}
