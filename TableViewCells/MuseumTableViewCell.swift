//
//  MuseumTableViewCell.swift
//  apiTest
//
//  Created by Maruf Khan on 31/5/21.
//

import UIKit
import Alamofire
class MuseumTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {

    
    @IBOutlet var viewAll: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mBlogCollectionView: UICollectionView!
    
    var blogcount: Int = 0
    var image_link = ""
    var jsonArray = [ResponseDatum]()
    override func awakeFromNib() {
        super.awakeFromNib()
        getData(from: url) {
            self.mBlogCollectionView.reloadData()
            self.blogcount = self.jsonArray[2].museum_blogs!.count
            //print("archive:\(self.archivecount)")
        }
        
        self.mBlogCollectionView.delegate = self
        self.mBlogCollectionView.dataSource = self
        self.mBlogCollectionView.register(UINib.init(nibName: "MuseumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MuseumCollectionViewCell")
        
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
        return blogcount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MuseumCollectionViewCell", for: indexPath) as! MuseumCollectionViewCell

        let i = indexPath.row
        
        cell.titleDesc.text = jsonArray[2].museum_blogs![i].title
        cell.location.text = jsonArray[2].museum_blogs![i].location
        image_link = jsonArray[2].museum_blogs![i].image_link
        cell.mBlogView.downloaded(from: image_link)


        return cell
    }
    
}
