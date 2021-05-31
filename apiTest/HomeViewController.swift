//
//  HomeViewController.swift
//  apiTest
//
//  Created by Maruf Khan on 26/5/21.
//

import UIKit
import Alamofire
class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var jsonArray = [ResponseDatum]()
    var bannersCount: Int = 0
    var archivecount: Int = 0
    var museumcount: Int = 0
    var eventscount: Int = 0
    var noticecount: Int = 0
    var aboutcount: Int = 0
    var gallerycount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData(from: url) {
            self.tableView.reloadData()
            self.bannersCount = self.jsonArray[0].banners!.count
            //print("banner:\(self.bannersCount)")
            self.archivecount = self.jsonArray[1].archieves!.count
            //print("archive:\(self.archivecount)")
            self.museumcount = self.jsonArray[2].museum_blogs!.count
            //print("museum:\(self.museumcount)")
            self.eventscount = self.jsonArray[3].events!.count
            //print("event:\(self.eventscount)")
            self.noticecount = self.jsonArray[4].notices!.count
            //print("notice:\(self.noticecount)")
            self.aboutcount = self.jsonArray[5].about_us!.count
            //print("about:\(self.aboutcount)")
            self.gallerycount = self.jsonArray[6].galleries!.count
            //print("gal:\(self.gallerycount)")
        }
        
        
        tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TVCell")
        tableView.register(UINib.init(nibName: "ArchieveTableViewCell", bundle: nil), forCellReuseIdentifier: "ArchieveTableViewCell")
        tableView.register(UINib.init(nibName: "MuseumTableViewCell", bundle: nil), forCellReuseIdentifier: "MuseumTableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //getData(from: url)
        
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let i = indexPath.row
        if i == 0 {
            return 188
        }
        if i == 1 {
            return 395
        }
        if i == 2 {
            return 464
        }
        
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let i = indexPath.row
        
        if i == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! TableViewCell
            return cell
            
        }
        if i == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArchieveTableViewCell", for: indexPath) as! ArchieveTableViewCell
            return cell
        }
        if i == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MuseumTableViewCell", for: indexPath) as! MuseumTableViewCell
            return cell
        }
        
        return UITableViewCell()
    }
    

    
    
}

