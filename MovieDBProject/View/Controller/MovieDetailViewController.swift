//
//  MovieDetailViewController.swift
//  MovieDBProject
//
//  Created by MacBook on 07/06/21.
//

import UIKit

struct defaultsKeys {
    static let idArray = "idArray"
}

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var watchTrailerButton: UIButton!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    var movieViewModel: MovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    public func initData(movieViewModel: MovieViewModel){
        self.movieViewModel = movieViewModel
    }
    
    func setupView(){
        // Setup Image
        addToFavoriteButton.layer.borderColor = UIColor.yellow.cgColor
        let addButtonRecognizer = UITapGestureRecognizer()
        addButtonRecognizer.addTarget(self, action: #selector(saveData))
        addToFavoriteButton.addGestureRecognizer(addButtonRecognizer)
        
        if let movie = movieViewModel {
            let imageUrl = CommonCons.pathURLImage + movie.backdropPath
            ImageUtils.loadImage(urlString: imageUrl) { (urlString, image) in
                // Caching image data
                ImageUtils.cacheImage(urlString: urlString, img: image!)
                self.backdropImageView.image = image
            }
        }
        
        titleLabel.text = movieViewModel?.title
        durationLabel.text = movieViewModel?.releaseDate
        overviewLabel.text = movieViewModel?.overview
    }
    
    @objc func saveData(){
        let defaults = UserDefaults.standard
        if var idArray = defaults.array(forKey: defaultsKeys.idArray) as? [Int]{
            if let id = self.movieViewModel?.id {
                idArray.append(id)
                defaults.set(idArray, forKey: defaultsKeys.idArray)
            }
        } else {
            defaults.set([movieViewModel?.id], forKey: defaultsKeys.idArray)
        }
    }
    
    

}
