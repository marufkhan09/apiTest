//
//  GalleryTableViewCell.swift
//  apiTest
//
//  Created by Maruf Khan on 31/5/21.
//

import UIKit
import Alamofire

class GalleryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet var titleName: UILabel!
    @IBOutlet var viewAll: UIButton!
    @IBOutlet var galleryCollectionView: UICollectionView!
    
    var photocount = 0
    var image_link = ""
    var jsonArray = [ResponseDatum]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getData(from: url) {
            self.galleryCollectionView.reloadData()
            self.photocount = self.jsonArray[6].galleries!.count
            //print("archive:\(self.archivecount)")
        }
        
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.dataSource = self
        self.galleryCollectionView.register(UINib.init(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getData(from url : String, completed: @escaping ()-> ()) {

        AF.request(url, method: .get,encoding: JSONEncoding.default).responseJSON { (response) in
            guard let data = response.data
            else{
                return
            }
            do{
                self.jsonArray = try JSONDecoder().decode([ResponseDatum].self, from: data)
                //print(self.jsonArray)
                DispatchQueue.main.async {
                    completed()
                }

            }
            catch{
                print("error decoding: \(error)")

            }

        }.resume()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photocount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell

        let i = indexPath.row
        

        image_link = jsonArray[6].galleries![i].image_link
        cell.imageView.downloaded(from: image_link)

        return cell
    }
    
    
}
