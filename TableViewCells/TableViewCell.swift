//
//  TableViewCell.swift
//  apiTest
//
//  Created by Maruf Khan on 27/5/21.
//

import UIKit
import Alamofire

class TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var image_link = ""
    var jsonArray = [ResponseDatum]()
    var bannersCount: Int = 0
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        getData(from: url) {
            self.collectionView.reloadData()
            self.bannersCount = self.jsonArray[0].banners!.count
            //print("banner:\(self.bannersCount)")

        }
//        networkCall().getData(from: url) {
//
//            self.bannersCount = networkCall().jsonData.count
//            print(self.bannersCount)
//            self.collectionView.reloadData()
//        }
        
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
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
        
        //return bannersCount
        return bannersCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        
        //print(jsonArray.count)
        //        for index in 0..<bannersCount {
        //            image_link = jsonArray[0].banners![index].image_link
        //            imageView?.downloaded(from: image_link)
        //
        //        }
        let i = indexPath.row
        //main link
        image_link = jsonArray[0].banners![i].image_link
        cell.bannerImage.downloaded(from: image_link)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 335, height: 188)
    }
    
    
}





