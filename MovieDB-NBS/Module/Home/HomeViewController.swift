//
//  HomeViewController.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var comingSoonCollectionView: UICollectionView!
    
    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        fetchData()
        setupView()
    }
    
    func fetchData(){
        viewModel.getBannerMovies()
        viewModel.getPopularMovies()
        viewModel.getComingSoonMovies()
        self.popularCollectionView.reloadData()
        self.comingSoonCollectionView.reloadData()
        self.bannerCollectionView.reloadData()
    }
    
    func setupView(){
        let bannerNib = UINib(nibName: "BannerCollectionViewCell", bundle: nil)
        bannerCollectionView.register(bannerNib, forCellWithReuseIdentifier: "bannerCardIdentifier")
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        let comingSoonNib = UINib(nibName: "ComingSoonCollectionViewCell", bundle: nil)
        comingSoonCollectionView.register(comingSoonNib, forCellWithReuseIdentifier: "comingSoonCardIdentifier")
        comingSoonCollectionView.dataSource = self
        comingSoonCollectionView.delegate = self
        let popularNib = UINib(nibName: "PopularCollectionViewCell", bundle: nil)
        popularCollectionView.register(popularNib, forCellWithReuseIdentifier: "popularCardIdentifier")
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        
        scrollView.bounces = false
        scrollView.backgroundColor = UIColor(red: 32/255.0, green: 33/255.0, blue: 35/255.0, alpha: 1.0)
        
        self.notificationButton.setTitle("", for: .normal)
        self.notificationButton.setImage(UIImage(systemName: "bell"), for: .normal)
        scrollView.contentInsetAdjustmentBehavior = .always
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func navigateToDetail(id: Int){
        let vc = DetailViewController(viewModel: DetailViewModel(useCase: Injection.init().provideDetail()))
        vc.id = id
        vc.modalPresentationStyle = .fullScreen
        vc.navigationController?.isNavigationBarHidden = true
        self.navigationController?.present(vc, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.bannerCollectionView {
            return viewModel.bannerMovies.value.count
        } else if collectionView == self.popularCollectionView {
            return viewModel.popularMovies.value.count
        } else if collectionView == self.comingSoonCollectionView {
            return viewModel.comingSoonMovies.value.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.bannerCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCardIdentifier", for: indexPath) as! BannerCollectionViewCell
            cell.delegate = self
            cell.movie = viewModel.bannerMovies.value[indexPath.row]
            return cell
        }
        else if collectionView == self.comingSoonCollectionView {
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "comingSoonCardIdentifier", for: indexPath) as! ComingSoonCollectionViewCell
            cell3.delegate = self
            cell3.movie = viewModel.comingSoonMovies.value[indexPath.row]
            return cell3
        }
        else if collectionView == self.popularCollectionView {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCardIdentifier", for: indexPath) as! PopularCollectionViewCell
            cell2.delegate = self
            cell2.movie = viewModel.popularMovies.value[indexPath.row]
            return cell2
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.bannerCollectionView {
            return CGSize(width: 418, height: 261)
        }
        else if collectionView == popularCollectionView
        {
            return CGSize(width: 103.41, height: 157)
        }
        else if collectionView == comingSoonCollectionView{
            return CGSize(width: 103.41, height: 157)
        }
        else {
            return CGSize(width: 103.41, height: 157)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.bannerCollectionView {
            let currentMovie = viewModel.bannerMovies.value[indexPath.row]
            navigateToDetail(id: currentMovie.id)
        } else if collectionView == self.popularCollectionView {
            let currentMovie = viewModel.popularMovies.value[indexPath.row]
            navigateToDetail(id: currentMovie.id)
        } else if collectionView == self.comingSoonCollectionView {
            let currentMovie = viewModel.comingSoonMovies.value[indexPath.row]
            navigateToDetail(id: currentMovie.id)
        }
    }
}

extension HomeViewController: BannerCollectionViewCellDelegate, PopularCollectionViewCellDelegate, ComingSoonCollectionViewCellDelegate {
    func listBannerDidTap(movie: MovieModel) {
        navigateToDetail(id: movie.id)
    }
    
    func listPopularDidTap(movie: MovieModel) {
        navigateToDetail(id: movie.id)
    }
    
    func listComingSoonDidTap(movie: MovieModel) {
        navigateToDetail(id: movie.id)
    }
    
    
}
