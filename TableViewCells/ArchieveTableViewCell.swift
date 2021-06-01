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

    @IBOutlet var viewAll: UIButton!
    @IBOutlet var archievelbl: UILabel!
    @IBOutlet var arcCollectionView: UICollectionView!
    var archievecount: Int = 0
    var video_link = ""
    var jsonArray = [ResponseDatum]()
    var audioArray = [AudioList]()
    override func awakeFromNib() {
        super.awakeFromNib()
        getData(from: url) {
            self.arcCollectionView.reloadData()
            self.archievecount = self.jsonArray[1].archieves!.count

        }
        
        self.arcCollectionView.delegate = self
        self.arcCollectionView.dataSource = self
        self.arcCollectionView.register(UINib.init(nibName: "ArchieveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArchieveCollectionViewCell")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    @IBAction func viewAll(_ sender: Any) {
//        
//        getAudioDetail {
//            print("success")
//        }
//        
//    }
    
    
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
    
    func getAudioDetail(completed: @escaping ()-> ()) {
        
        let allAudio = "\(base_url)"+"api/v1/audio_books/list"
        AF.request(allAudio, method: .get,encoding: JSONEncoding.default).responseJSON { (response) in
            guard let data = response.data
            else{
                return
            }
            do{
                self.audioArray = try JSONDecoder().decode([AudioList].self, from: data)
                print(self.audioArray)
                
                DispatchQueue.main.async {
                    completed()
                }

            }
            catch{
                print("error decoding: \(error)")

            }

        }.resume()

    }
    

    

    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return archievecount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArchieveCollectionViewCell", for: indexPath) as! ArchieveCollectionViewCell

        let i = indexPath.row
        cell.titleDesc.text = jsonArray[1].archieves![i].title
        video_link = jsonArray[1].archieves![i].video_url
        cell.vidImage.image = getThumbnailImage(forUrl:URL(string: video_link)!)

        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}
