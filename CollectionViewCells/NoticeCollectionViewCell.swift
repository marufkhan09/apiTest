//
//  NoticeCollectionViewCell.swift
//  apiTest
//
//  Created by Maruf Khan on 31/5/21.
//

import UIKit

class NoticeCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleDesc: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var fullNotice: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
