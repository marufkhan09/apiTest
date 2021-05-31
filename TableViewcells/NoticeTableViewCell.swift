//
//  NoticeTableViewCell.swift
//  apiTest
//
//  Created by Maruf Khan on 31/5/21.
//

import UIKit
import Alamofire
class NoticeTableViewCell:  UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout   {
    
    @IBOutlet var noticeLabel: UILabel!
    @IBOutlet var viewAll: UIButton!
    @IBOutlet var noticeCollectionView: UICollectionView!
    

    var noticecount = 0
    var image_link = ""
    var jsonArray = [ResponseDatum]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getData(from: url) {
            self.noticeCollectionView.reloadData()
            self.noticecount = self.jsonArray[4].museum_blogs!.count
            //print("archive:\(self.archivecount)")
        }
        
        self.noticeCollectionView.delegate = self
        self.noticeCollectionView.dataSource = self
        self.noticeCollectionView.register(UINib.init(nibName: "NoticeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NoticeCollectionViewCell")
        
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
        return noticecount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView

        let i = indexPath.row
        
        cell.titleDesc.text = jsonArray[3].events![i].title
        cell.location.text = jsonArray[3].events![i].location
        image_link = jsonArray[3].events![i].cover_image
        cell.evImage.downloaded(from: image_link)

        return cell
    }
    
}
