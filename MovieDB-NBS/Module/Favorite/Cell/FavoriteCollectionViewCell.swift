//
//  FavoriteCollectionViewCell.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 20/06/21.
//

import UIKit
import SDWebImage

protocol FavoriteCollectionViewCellDelegate: AnyObject{
    func listFavoriteTapped(movie: MovieModel)
}


class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var releasedDate: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    weak var delegate: FavoriteCollectionViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var movie: MovieModel? {
        didSet{
            guard let title = movie?.title, let date = movie?.releaseDate, let url = movie?.backdropPath, let favorite = movie?.favorite, let genres = movie?.genre else { return}
            let imageUrl = MovieConstant.imageUrl + url
            movieImage.sd_setImage(with: URL(string: imageUrl))
            movieTitle.text = title
            releasedDate.text = date
            var index = 0
            for genre in genres {
                movieGenre.text! += genre.name
                index += 1
                if index == genres.count{
                    break
                } else if index < 4 {
                    break
                } else {
                    movieGenre.text! += ", "
                }
            }
            
            if favorite == true {
                favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                favoriteButton.setTitle("", for: .normal)
            } else {
                favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                favoriteButton.setTitle("", for: .normal)
            }
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.listFavoriteTapped))
            movieImage.addGestureRecognizer(tapGR)
            movieImage.isUserInteractionEnabled = true
        }
    }
    
    @objc func listFavoriteTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if tapGestureRecognizer.state == .ended{
            delegate?.listFavoriteTapped(movie: movie!)
        }
    }

}
