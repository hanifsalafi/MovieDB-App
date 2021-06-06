//
//  HomeViewController.swift
//  MovieDBProject
//
//  Created by MacBook on 07/06/21.
//

import UIKit
import RxSwift
import RxCocoa


class HomeViewController: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var popularHomeCollectionView: UICollectionView!
    @IBOutlet weak var comingSoonCollectionView: UICollectionView!
    
    var disposeBag = DisposeBag()
    var movieBannerViewModel: MovieBannerListViewModel?
    
    private var popularMovieList: [MovieViewModel] = []
    private var upcomingMovieList: [MovieViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    func fetchData(){
        let service = MovieService.shared
        let movieBannerListViewModel = MovieBannerListViewModel(movieService: service)
        movieBannerViewModel = movieBannerListViewModel
        
        // Fetch Banner and Popular Movies
        movieBannerViewModel?.fetchMovieBannerListViewModel()?
                    .observe(on: MainScheduler.instance)
                    .subscribe(
                       onNext: { data in
                            self.popularMovieList = data
                            self.bannerCollectionView.reloadData()
                            self.popularHomeCollectionView.reloadData()
                       },
                       onError: { error in
                           print("Error downloading: \(error)")
                    })
                    .disposed(by: disposeBag)
        
        // Fetch Coming Soon Movies
        movieBannerViewModel?.fetchUpcomingMovieListViewModel()?
                    .observe(on: MainScheduler.instance)
                    .subscribe(
                       onNext: { data in
                            self.upcomingMovieList = data
                            self.comingSoonCollectionView.reloadData()
                       },
                       onError: { error in
                           print("Error downloading: \(error)")
                    })
                    .disposed(by: disposeBag)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return self.popularMovieList.count
        } else if collectionView == popularHomeCollectionView {
            if self.popularMovieList.count < 10 {
                return self.popularMovieList.count
            } else {
                return 10
            }
        } else {
            if self.upcomingMovieList.count < 10 {
                return self.upcomingMovieList.count
            } else {
                return 10
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeBannerCell", for: indexPath) as! HomeBannerCollectionViewCell
            
            let banner = self.popularMovieList[indexPath.row]
            let pathImage = banner.backdropPath
            let imageUrl = CommonCons.pathURLImage+pathImage
            cell.configure(imageURL: imageUrl)
            
            return cell
        } else if collectionView == popularHomeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularHomeCell", for: indexPath) as! PopularHomeCollectionViewCell
            
            let banner = self.popularMovieList[indexPath.row]
            let pathImage = banner.posterPath
            let imageUrl = CommonCons.pathURLImage+pathImage
            cell.configure(imageURL: imageUrl)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comingSoonCell", for: indexPath) as! ComingSoonCollectionViewCell
            
            let banner = self.upcomingMovieList[indexPath.row]
            let pathImage = banner.posterPath
            let imageUrl = CommonCons.pathURLImage+pathImage
            cell.configure(imageURL: imageUrl)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
            return CGSize(width: self.view.frame.width * 0.4, height: self.bannerCollectionView.bounds.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

        }
    }
    
}

extension HomeViewController: UIScrollViewDelegate {
    
    func centerCell() {
        let centerPoint = CGPoint(x: bannerCollectionView.contentOffset.x + bannerCollectionView.frame.midX, y: 100)
        if let path = bannerCollectionView.indexPathForItem(at: centerPoint){
            bannerCollectionView.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerCell()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        centerCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerCell()
        }
    }
    
}
