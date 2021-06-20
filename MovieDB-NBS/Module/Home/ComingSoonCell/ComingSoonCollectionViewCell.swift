//
//  ComingSoonCollectionViewCell.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 20/06/21.
//

import UIKit
import SDWebImage
class ComingSoonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var comingSoonImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var movie: MovieModel? {
        didSet {
            guard let url = movie?.posterPath else {return}
            let imageUrl = MovieConstant.baseUrl + url
            comingSoonImage.sd_setImage(with: URL(string: imageUrl))
        }
    }

}
