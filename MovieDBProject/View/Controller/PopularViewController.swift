//
//  PopularViewController.swift
//  MovieDBProject
//
//  Created by MacBook on 07/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class PopularViewController: UIViewController {

    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    var disposeBag = DisposeBag()
    var popularMoviesViewModel: PopularMovieListViewModel?
    
    private var popularMovieList: [MovieViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    func fetchData(){
        let service = MovieService.shared
        let popularMovieListViewModel = PopularMovieListViewModel(movieService: service)
        popularMoviesViewModel = popularMovieListViewModel
        
        // Fetch Popular Movies
        popularMoviesViewModel?.fetchPopularMovieListViewModel()?
                    .observe(on: MainScheduler.instance)
                    .subscribe(
                       onNext: { data in
                            self.popularMovieList = data
                            self.popularCollectionView.reloadData()
                       },
                       onError: { error in
                           print("Error downloading: \(error)")
                    })
                    .disposed(by: disposeBag)
    }

}


extension PopularViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! PopularCollectionViewCell
        
        let popularMovie = popularMovieList[indexPath.row]
        let pathImage = popularMovie.posterPath
        let imageUrl = CommonCons.pathURLImage+pathImage
        cell.configure(title: popularMovie.title, desc: popularMovie.overview, imageURL: imageUrl)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2, height: 250)
    }
    
}
