////
////  networkCall.swift
////  apiTest
////
////  Created by Maruf Khan on 30/5/21.
//
//
//import Foundation
//import Alamofire
//
//
//class networkCall {
//
//    var jsonData = [ResponseDatum]()
//
//    func getData(from url : String, completed: @escaping ()-> ()) {
//
//
//        AF.request(url, method: .get,encoding: JSONEncoding.default).responseJSON { (response) in
//            guard let data = response.data
//            else{
//                return
//            }
//            do{
//
//                self.jsonData = try JSONDecoder().decode([ResponseDatum].self, from: data)
//                //print(self.jsonArray)
//                DispatchQueue.main.async {
//                    completed()
//                }
//
//
//            }
//            catch{
//                print("error decoding: \(error)")
//
//            }
//
//        }.resume()
//
//    }
//}
//
