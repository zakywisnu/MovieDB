//
//  PopularTabCollectionViewCell.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 20/06/21.
//

import UIKit
import SDWebImage

protocol PopularTabCollectionViewCellDelegate: AnyObject {
    func listPopularTabDidTap(movie: MovieModel)
}

class PopularTabCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    weak var delegate: PopularTabCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    var movie: MovieModel? {
        didSet{
            guard let url = movie?.posterPath, let title = movie?.title else {return}
            let imageUrl = MovieConstant.imageUrl + url
            movieImage.sd_setImage(with: URL(string: imageUrl))
            movieTitle.text = title
        }
    }

    @IBAction func listPopularTouched(_ sender: Any) {
        delegate?.listPopularTabDidTap(movie: movie!)
    }
}
