//
//  AudioBookCollectionViewCell.swift
//  apiTest
//
//  Created by Maruf Khan on 4/6/21.
//

import UIKit

class AudioBookCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleName: UILabel!
    @IBOutlet var audioDesc: UILabel!
    @IBOutlet var play: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
