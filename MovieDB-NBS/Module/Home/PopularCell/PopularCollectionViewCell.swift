//
//  PopularCollectionViewCell.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 20/06/21.
//

import UIKit
import SDWebImage
class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    var movie: MovieModel? {
        didSet {
            guard let url = movie?.posterPath else{return}
            let imageUrl = MovieConstant.baseUrl + url
            movieImage.sd_setImage(with: URL(string: imageUrl))
        }
    }
    

}
