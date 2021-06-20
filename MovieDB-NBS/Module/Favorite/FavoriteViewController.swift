//
//  FavoriteViewController.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 19/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var viewModel: FavoriteViewModel
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var movieList:[MovieModel] = []
    let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        registerObserver()
        fetchData()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func registerObserver(){
        viewModel.movies.subscribe(onNext: { [weak self] listMovie in
            self?.movieList = listMovie
            self?.favoriteCollectionView.reloadData()
        }).disposed(by: disposeBag)
        
        textField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                if !query.isEmpty {
                    self?.viewModel.searchFavoriteMovies(query: query)
                } else {
                    self?.movieList = self?.viewModel.movies.value ?? []
                    self?.favoriteCollectionView.reloadData()
                }
            }).disposed(by: disposeBag)
        viewModel.searchMovies.subscribe(onNext: { [weak self] listMovie in
            if !listMovie.isEmpty {
                self?.movieList = listMovie
                self?.favoriteCollectionView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
    func fetchData(){
        viewModel.getPopularMovie()
        favoriteCollectionView.reloadData()
    }
    
    func setupView(){
        let favoriteNib = UINib(nibName: "FavoriteCollectionViewCell", bundle: nil)
        favoriteCollectionView.register(favoriteNib, forCellWithReuseIdentifier: "favoriteCardIdentifier")
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
        let imageView = UIImageView()
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        imageView.tintColor = UIColor(red: 255/255.0, green: 209/255.0, blue: 48/255.0, alpha: 1.0)
        textField.rightViewMode = .always
        textField.rightView = imageView
    }
    
    func navigateToDetail(id: Int){
        let vc = DetailViewController(viewModel: DetailViewModel(useCase: Injection.init().provideDetail()))
        vc.id = id
        vc.modalPresentationStyle = .fullScreen
        vc.navigationController?.isNavigationBarHidden = true
        self.navigationController?.present(vc, animated: true)
    }

}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCardIdentifier", for: indexPath) as! FavoriteCollectionViewCell
        cell.delegate = self
        cell.movie = movieList[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: favoriteCollectionView.frame.width, height: 89)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentMovie = movieList[indexPath.row]
        navigateToDetail(id: currentMovie.id)
    }
}

extension FavoriteViewController: FavoriteCollectionViewCellDelegate{
    func listFavoriteTapped(movie: MovieModel) {
        navigateToDetail(id: movie.id)
    }
}
