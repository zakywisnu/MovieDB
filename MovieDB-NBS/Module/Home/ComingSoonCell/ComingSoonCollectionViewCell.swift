//
//  ComingSoonCollectionViewCell.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 20/06/21.
//

import UIKit
import SDWebImage

protocol ComingSoonCollectionViewCellDelegate: AnyObject {
    func listComingSoonDidTap(movie: MovieModel)
}

class ComingSoonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var comingSoonImage: UIImageView!
    weak var delegate: ComingSoonCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var movie: MovieModel? {
        didSet {
            guard let url = movie?.posterPath else {return}
            let imageUrl = MovieConstant.imageUrl + url
            comingSoonImage.sd_setImage(with: URL(string: imageUrl))
        }
    }

    @IBAction func listComingSoonTouched(_ sender: Any) {
        delegate?.listComingSoonDidTap(movie: movie!)
    }
}
