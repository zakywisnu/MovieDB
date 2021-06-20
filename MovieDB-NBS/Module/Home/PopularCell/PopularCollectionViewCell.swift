//
//  PopularCollectionViewCell.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 20/06/21.
//

import UIKit
import SDWebImage

protocol PopularCollectionViewCellDelegate: AnyObject {
    func listPopularDidTap(movie: MovieModel)
}

class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    weak var delegate: PopularCollectionViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    var movie: MovieModel? {
        didSet {
            guard let url = movie?.posterPath else{return}
            let imageUrl = MovieConstant.imageUrl + url
            movieImage.sd_setImage(with: URL(string: imageUrl))
        }
    }
    
    @IBAction func listPopularTouched(_ sender: Any) {
        delegate?.listPopularDidTap(movie: movie!)
    }
    

}
