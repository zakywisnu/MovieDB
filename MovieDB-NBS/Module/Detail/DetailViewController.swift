//
//  DetailViewController.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 20/06/21.
//

import UIKit
import SDWebImage
class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRuntime: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var trailerButton: UIButton!
    var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var id: Int?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insetsLayoutMarginsFromSafeArea = false
        fetchData()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func fetchData(){
        guard let id = id else {
            return
        }
        viewModel.getDetailMovie(id: id)
    }
    override func viewDidAppear(_ animated: Bool) {
        insertData()
    }
    
    @IBAction func onBackTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func insertData(){
        var index = 0
        movieImage.sd_setImage(with: URL(string: MovieConstant.imageUrl + viewModel.movie.value.posterPath))
        movieTitle.text = viewModel.movie.value.title
        movieRuntime.text = "\(viewModel.movie.value.runtime)m"
        movieDescription.text = viewModel.movie.value.overview
        for genre in viewModel.movie.value.genre {
            
            movieGenre.text! += genre.name
            index += 1
            if index == viewModel.movie.value.genre.count {
                break
            } else if index == 4{
                break
            } else {
                movieGenre.text! += " • "
            }
        }
        if viewModel.movie.value.favorite == true {
            favoriteButton.setTitle("Remove Favorite", for: .normal)
            favoriteButton.setImage(UIImage(systemName: "minus"), for: .normal)
//            favoriteButton.backgroundColor = UIColor(red: 255/255.0, green: 209/255.0, blue: 48/255.0, alpha: 1.0)
            favoriteButton.layer.borderWidth = 0
            favoriteButton.setTitleColor(UIColor.white, for: .normal)
            
            
        } else {
            favoriteButton.setTitle("Add to Favorite", for: .normal)
            favoriteButton.setImage(UIImage(systemName: "plus"), for: .normal)
            favoriteButton.backgroundColor = UIColor.clear
            favoriteButton.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.12)
            favoriteButton.layer.borderWidth = 4
            favoriteButton.setTitleColor(UIColor.white, for: .normal)
            favoriteButton.tintColor = UIColor.white
        }
        
    }
    
    func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        
        movieDescription.textAlignment = .justified
        
        trailerButton.layer.cornerRadius = 4
        favoriteButton.layer.cornerRadius = 4
        if viewModel.movie.value.favorite == true {
            favoriteButton.setTitle("Remove Favorite", for: .normal)
            favoriteButton.setImage(UIImage(systemName: "minus"), for: .normal)
//            favoriteButton.backgroundColor = UIColor(red: 255/255.0, green: 209/255.0, blue: 48/255.0, alpha: 1.0)
            favoriteButton.layer.borderWidth = 0
            favoriteButton.setTitleColor(UIColor.white, for: .normal)
            
            
        } else {
            favoriteButton.setTitle("Add to Favorite", for: .normal)
            favoriteButton.setImage(UIImage(systemName: "plus"), for: .normal)
            favoriteButton.backgroundColor = UIColor.clear
            favoriteButton.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.12)
            favoriteButton.setTitleColor(UIColor.white, for: .normal)
            favoriteButton.layer.borderWidth = 4
            favoriteButton.setTitleColor(UIColor.white, for: .normal)
            favoriteButton.tintColor = UIColor.white
        }
        backButton.setTitle("", for: .normal)
    }
    
    @IBAction func favoriteButtonTapped(sender: UIButton){
        guard let id = id else {
            return
        }
        viewModel.updateFavoriteStatus(id: id)
        if viewModel.movie.value.favorite == true {
            favoriteButton.setTitle("Remove Favorite", for: .normal)
            favoriteButton.setImage(UIImage(systemName: "minus"), for: .normal)
//            favoriteButton.backgroundColor = UIColor(red: 255/255.0, green: 209/255.0, blue: 48/255.0, alpha: 1.0)
            favoriteButton.layer.borderWidth = 0
            favoriteButton.setTitleColor(UIColor.white, for: .normal)
            
            
        } else {
            favoriteButton.setTitle("Add to Favorite", for: .normal)
            favoriteButton.setImage(UIImage(systemName: "plus"), for: .normal)
            favoriteButton.backgroundColor = UIColor.clear
            favoriteButton.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.12)
            favoriteButton.layer.borderWidth = 4
            favoriteButton.setTitleColor(UIColor.white, for: .normal)
            favoriteButton.tintColor = UIColor.white
        }
    }

}
