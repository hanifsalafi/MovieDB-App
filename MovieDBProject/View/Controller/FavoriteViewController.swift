//
//  FavoriteViewController.swift
//  MovieDBProject
//
//  Created by MacBook on 07/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var disposeBag = DisposeBag()
    var favoriteMovieViewModel: FavoriteMovieViewModel?
    
    var favoriteMovies: [MovieResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData(){
        var dataArray: [Int] = []
        let defaults = UserDefaults.standard
        if let idArray = defaults.array(forKey: defaultsKeys.idArray) as? [Int]{
            if idArray.count > 0 {
                dataArray = idArray
            }
        }
        for id in dataArray {
            fetchData(id: id)
        }
        
    }
    
    func fetchData(id: Int) {
        let service = MovieService.shared
        let movieViewModel = FavoriteMovieViewModel(movieService: service)
        favoriteMovieViewModel = movieViewModel
        
        favoriteMovieViewModel?.fetchMovieById(id: id)?
            .observe(on: MainScheduler.instance)
            .subscribe(
               onNext: { data in
                    self.favoriteMovies.append(data)
                    self.favoriteTableView.reloadData()
               },
               onError: { error in
                   print("Error downloading: \(error)")
            })
            .disposed(by: disposeBag)
        
        
    }

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        
        let movie = self.favoriteMovies[indexPath.row]
        cell.configure(title: movie.title, year: movie.releaseDate, desc: movie.overview, imageURL: movie.backdropPath)
        return cell
    }
    
    
}

