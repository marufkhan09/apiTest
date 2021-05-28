//
//  TableViewCell.swift
//  apiTest
//
//  Created by Maruf Khan on 27/5/21.
//

import UIKit
import Alamofire

class TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    var id: Int = 0
    var image_link = ""
    var jsonArray = [ResponseDatum]()
    var bannersCount: Int = 0
    
    
    
   // let userDefaults = UserDefaults()

    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        getData(from: url) {
            self.collectionView.reloadData()
//            print("success")
//            print(self.jsonArray.count)
            self.bannersCount = self.jsonArray[0].banners!.count
        }
        
        
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
        print("this is : \(bannersCount)")
        return bannersCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        
        //print(jsonArray.count)
//        for index in 0..<jsonArray[0].banners!.count {
//            self.image_link = jsonArray[0].banners![index].image_link
//            imageView?.downloaded(from: image_link)
//        }
        
        
        return cell
    }
    
}





