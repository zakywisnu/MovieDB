//
//  BannerCollectionViewCell.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 20/06/21.
//

import UIKit
import SDWebImage

protocol BannerCollectionViewCellDelegate: AnyObject {
    func listBannerDidTap(movie: MovieModel)
}

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    
    weak var delegate: BannerCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var movie: MovieModel? {
        didSet {
            guard let url = movie?.backdropPath else { return }
            let imageUrl = MovieConstant.imageUrl + url
            bannerImage.sd_setImage(with: URL(string: imageUrl))
        }
    }
    
    @IBAction func listBannerTouched(_ sender: Any) {
        delegate?.listBannerDidTap(movie: movie!)
    }

}
