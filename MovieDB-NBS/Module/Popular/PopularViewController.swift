//
//  PopularViewController.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 19/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class PopularViewController: UIViewController {

    @IBOutlet weak var popularCollectionView: UICollectionView!
    var viewModel: PopularViewModel
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var movieList:[MovieModel] = []
    let disposeBag = DisposeBag()
    
    init(viewModel: PopularViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    var itemsPerRow: CGFloat = 2
    
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
    
    func registerObserver(){
        viewModel.movies.subscribe(onNext: { [weak self] listMovie in
            self?.movieList = listMovie
            self?.popularCollectionView.reloadData()
        }).disposed(by: disposeBag)
        
        searchTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                if !query.isEmpty {
                    self?.viewModel.searchPopularMovies(query: query)
                } else {
                    self?.movieList = self?.viewModel.movies.value ?? []
                    self?.popularCollectionView.reloadData()
                }
            }).disposed(by: disposeBag)
        viewModel.searchMovies.subscribe(onNext: { [weak self] listMovie in
            if !listMovie.isEmpty {
                self?.movieList = listMovie
                self?.popularCollectionView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
    func fetchData(){
        viewModel.getPopularMovie()
        popularCollectionView.reloadData()
    }
    
    func setupView(){
        let popularNib = UINib(nibName: "PopularTabCollectionViewCell", bundle: nil)
        popularCollectionView.register(popularNib, forCellWithReuseIdentifier: "popularTabIdentifier")
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        
        let imageView = UIImageView()
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        imageView.tintColor = UIColor(red: 255/255.0, green: 209/255.0, blue: 48/255.0, alpha: 1.0)
        searchTextField.rightViewMode = .always
        searchTextField.rightView = imageView
    }
    func navigateToDetail(id: Int){
        let vc = DetailViewController(viewModel: DetailViewModel(useCase: Injection.init().provideDetail()))
        vc.id = id
        vc.modalPresentationStyle = .fullScreen
        vc.navigationController?.isNavigationBarHidden = true
        self.navigationController?.present(vc, animated: true)
    }
}

extension PopularViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularTabIdentifier", for: indexPath) as! PopularTabCollectionViewCell
        cell.delegate = self
        cell.movie = movieList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = self.popularCollectionView.frame.width / itemsPerRow
        return CGSize(width: availableWidth - 16, height: 264)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentMovie = movieList[indexPath.row]
        navigateToDetail(id: currentMovie.id)
    }
}

extension PopularViewController: PopularTabCollectionViewCellDelegate {
    func listPopularTabDidTap(movie: MovieModel) {
        navigateToDetail(id: movie.id)
    }
}
