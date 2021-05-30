//
//  ArchiveTableViewCell.swift
//  apiTest
//
//  Created by Maruf Khan on 30/5/21.
//

import UIKit
import Alamofire
import AVFoundation
class ArchieveTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet var archievelbl: UILabel!
    @IBOutlet var viewAll: UIButton!
    @IBOutlet var arcCollectionView: UICollectionView!
    var archievecount: Int = 0
    var video_link = ""
    var jsonArray = [ResponseDatum]()
    override func awakeFromNib() {
        super.awakeFromNib()
        getData(from: url) {
            self.arcCollectionView.reloadData()
            self.archievecount = self.jsonArray[1].archieves!.count
            //print("archive:\(self.archivecount)")
        }
        
        self.arcCollectionView.delegate = self
        self.arcCollectionView.dataSource = self
        self.arcCollectionView.register(UINib.init(nibName: "ArchieveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArchieveCollectionViewCell")
        
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
    
    func generateThumbnail(path: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: path, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return archievecount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArchieveCollectionViewCell", for: indexPath) as! ArchieveCollectionViewCell

        let i = indexPath.row
        //main link
//        image_link = jsonArray[0].banners![i].image_link
//        cell.bannerImage.downloaded(from: image_link)
        cell.titleDesc.text = jsonArray[1].archieves![i].title
        video_link = jsonArray[1].archieves![i].video_url
        cell.vidImage.image = self.generateThumbnail(path: URL(string: video_link)!)
        
       
        
        return cell
    }
    
}
