//
//  AboutUSTableViewCell.swift
//  apiTest
//
//  Created by Maruf Khan on 31/5/21.
//

import UIKit
import Alamofire
class AboutUSTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet var titleName: UILabel!
    @IBOutlet var viewAll: UIButton!
    @IBOutlet var aboutUsCollectionView: UICollectionView!
    
    var aboutcount = 0
    var image_link = ""
    var jsonArray = [ResponseDatum]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getData(from: url) {
            self.aboutUsCollectionView.reloadData()
            self.aboutcount = self.jsonArray[5].about_us!.count
            //print("archive:\(self.archivecount)")
        }
        
        self.aboutUsCollectionView.delegate = self
        self.aboutUsCollectionView.dataSource = self
        self.aboutUsCollectionView.register(UINib.init(nibName: "AboutUSCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AboutUSCollectionViewCell")
        
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
        return aboutcount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutUSCollectionViewCell", for: indexPath) as! AboutUSCollectionViewCell

        let i = indexPath.row
        
        cell.name.text = jsonArray[5].about_us![i].name
        cell.designation.text = jsonArray[5].about_us![i].designation
        image_link = jsonArray[5].about_us![i].image_link
        cell.imageView.downloaded(from: image_link)

        return cell
    }
    
}
