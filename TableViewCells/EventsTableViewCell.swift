//
//  MuseumTableViewCell.swift
//  apiTest
//
//  Created by Maruf Khan on 31/5/21.
//

import UIKit
import Alamofire
class EventsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var viewAll: UIButton!
    @IBOutlet var eventCollectionView: UICollectionView!
    
    var eventcount = 0
    var image_link = ""
    var jsonArray = [ResponseDatum]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getData(from: url) {
            self.eventCollectionView.reloadData()
            self.eventcount = self.jsonArray[3].events!.count
            //print("archive:\(self.archivecount)")
        }
        
        self.eventCollectionView.delegate = self
        self.eventCollectionView.dataSource = self
        self.eventCollectionView.register(UINib.init(nibName: "EventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventsCollectionViewCell")
        
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
        return eventcount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCollectionViewCell", for: indexPath) as! EventsCollectionViewCell

        let i = indexPath.row
        
        cell.titleDesc.text = jsonArray[3].events![i].title
        cell.location.text = jsonArray[3].events![i].location
        image_link = jsonArray[3].events![i].cover_image
        cell.evImage.downloaded(from: image_link)

        return cell
    }
    
}
