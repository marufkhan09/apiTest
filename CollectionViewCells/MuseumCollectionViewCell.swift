//
//  MuseumCollectionViewCell.swift
//  apiTest
//
//  Created by Maruf Khan on 31/5/21.
//

import UIKit

class MuseumCollectionViewCell: UICollectionViewCell {
    @IBOutlet var mBlogView: UIImageView!
    @IBOutlet var titleDesc: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var readMore: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
