//
//  AllAudioBooksCollectionViewCell.swift
//  apiTest
//
//  Created by Maruf Khan on 2/6/21.
//

import UIKit

class AllAudioBooksCollectionViewCell: UICollectionViewCell {
    @IBOutlet var audioBookImage: UIImageView!
    @IBOutlet var audioTitle: UILabel!
    @IBOutlet var audioDescription: UILabel!
    @IBOutlet var play: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
