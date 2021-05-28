//
//  ViewController.swift
//  apiTest
//
//  Created by Maruf Khan on 26/5/21.
//

import UIKit
import Alamofire
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 188
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! TableViewCell
        
        return cell
        
    }
    

//    var id = 0
//    var ttl = ""
//    var image_type = ""
//    var image_link = ""
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TVCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //getData(from: url)

        }
    
//    private func getData(from url : String){
//        AF.request(url, method: .get,encoding: JSONEncoding.default).responseJSON { (response) in
//            guard let data = response.data
//            else{
//                return
//            }
//            do{
//                let jsonData = try JSONDecoder().decode(ResponseData.self, from: data)
//
//                print(jsonData[1].archieves!.count)
//                for index in 0..<jsonData[1].archieves!.count{
//                    self.image_link = jsonData[1].archieves![index].video_url
//                    print(self.image_link)
//                }
//
//                for index in 0..<jsonData[0].banners!.count{
//                    self.ttl = jsonData[0].banners![index].title
//                    print(self.ttl)
//                }
//                
//
//            }
//            catch{
//                print("error decoding: \(error)")
//
//            }
//
//        }
//    }
      
    }

