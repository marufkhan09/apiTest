//
//  AllBlogsViewController.swift
//  apiTest
//
//  Created by Maruf Khan on 7/6/21.
//

import UIKit
import Alamofire
class AllBlogsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var collectionView: UICollectionView!
    
    var jsonArray = [MuseumBlog]()
    var blogCount = 0
    var image_link = ""
    let blog_url  = "\(base_url)"+"api/v1/museum_blogs/list"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "AllBlogsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllBlogsCollectionViewCell")
        
        getData(from: blog_url) {
            self.collectionView.reloadData()
            self.blogCount = self.jsonArray.count
            
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(jsonArray.count)
        return jsonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllBlogsCollectionViewCell", for: indexPath) as! AllBlogsCollectionViewCell
        let i = indexPath.row

        cell.date.text = jsonArray[i].published_date
        cell.titleDesc.text = jsonArray[i].description
        image_link = jsonArray[i].image_link
        cell.imageView.downloaded(from: image_link)
        
        if i == 0 || i % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.9591556191, blue: 0.9598774314, alpha: 0.5045802183)
        }
        else {
            cell.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9882352941, blue: 0.9607843137, alpha: 0.5)
        }
        
        
        return cell
    }
    
    
    
    func getData(from url : String, completed: @escaping ()-> ()) {
        
        AF.request(blog_url, method: .get,encoding: JSONEncoding.default).responseJSON { (response) in
            guard let data = response.data
            else{
                return
            }
            do{
                self.jsonArray = try JSONDecoder().decode([MuseumBlog].self, from: data)
                DispatchQueue.main.async {
                    completed()
                }
                
            }
            catch{
                print("error decoding: \(error)")
                
            }
            
        }.resume()
        
    }


}
