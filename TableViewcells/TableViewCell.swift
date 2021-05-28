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
    var jsonBanner = [Banner]()
    var jsonAboutUs = [AboutUs]()
    var jsonArchive = [Archieve]()
    var jsonMuseum = [MuseumBlog]()
    var jsonNotice = [Notice]()
    var jsonGallery = [Banner]()
    var jsonEvent = [Event]()
    
    
    
   // let userDefaults = UserDefaults()

    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        getData(from: url) {
            self.collectionView.reloadData()
//            print("success")
//            print(self.jsonArray.count)
        }
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//    func getData(from url : String, completionHandler: @escaping (_ result: ResponseData) -> ()){
//
////        var jsonResult = [ResponseDatum]()
//
//       AF.request(url, method: .get,encoding: JSONEncoding.default).responseJSON { (response) in
//           guard let data = response.data
//           else{
//               return
//           }
//           do{
//               let jsonData = try JSONDecoder().decode([ResponseDatum].self, from: data)
//
//
//                //   self.userDefaults.setValue(jsonData, forKey: "jsondata")
//            self.jsonArray = jsonData
//            completionHandler(self.jsonArray)
//
//
//
//               for index in 0..<jsonData[0].banners!.count{
//                   self.id = jsonData[0].banners![index].id
//                   self.image_link = jsonData[0].banners![index].image_link
//                   //print(self.image_link)
//               }
//           }
//           catch{
//               print("error decoding: \(error)")
//
//           }
//       }
//   }
    
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
    
    
//    func getData(from url : String, completionHandler: @escaping (_ result: ResponseData) ->Void) -> ResponseData {
//
//        var jsonResult = [ResponseDatum]()
//
//        AF.request(url, method: .get,encoding: JSONEncoding.default).responseJSON { (response) in
//            guard let data = response.data
//            else{
//                return
//            }
//            do{
//                let jsonData = try JSONDecoder().decode([ResponseDatum].self, from: data)
//
//                //   self.userDefaults.setValue(jsonData, forKey: "jsondata")
//                jsonResult = jsonData
//                completionHandler(jsonResult)
//
//                //               for index in 0..<jsonData[0].banners!.count{
//                //                   self.id = jsonData[0].banners![index].id
//                //                   self.image_link = jsonData[0].banners![index].image_link
//                //                   //print(self.image_link)
//                //
//                //               }
//
//            }
//            catch{
//                print("error decoding: \(error)")
//
//            }
//
//        }.resume()
//        print(jsonResult)
//        return jsonResult
//    }
    
//    func calculateRate(value: [String], completionHandler: (_ results: [String: Any])->()){
//
//        let url = URL(string: "domain.com")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let postString = "pairs=\(value[0] + value[2])&pairs=\(value[2]+value[0])"
//        print(postString)
//        request.httpBody = postString.data(using: String.Encoding.utf8)
//
//        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
//            do  {
//                let jsonResult = try  JSONSerialization.jsonObject(with: data!)
//                let results = jsonResult as! [String: Any]
//                completionHandler(results)
//
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
//    }
//
//    func fetchSomething(completion: @escaping (String -> Void)?) {
//        // setup request
//        let task = URLSession.shared.dataTask(with:request as URLRequest){
//                data, response, error in
//
//         let fakeMessage = "hi"
//         completion(fakeMessage)
//        }
//        task.resume()
//    }


    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jsonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        
        print(jsonArray.count)
        for index in 0..<jsonArray[0].banners!.count {
            self.image_link = jsonArray[0].banners![index].image_link
            imageView?.downloaded(from: image_link)
        }
        
        
        return cell
    }
    
}





