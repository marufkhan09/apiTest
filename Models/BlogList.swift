//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let blogList = try? newJSONDecoder().decode(BlogList.self, from: jsonData)
//
//import Foundation
//
//// MARK: - BlogListElement
////struct BlogList: Codable {
////    let id: Int
////    let title, location, blogListDescription, publishedDate: String
////    let type: String
////    let imageLink: String
////    let comments: [Comment]
////
////    enum CodingKeys: String, CodingKey {
////        case id, title, location
////        case blogListDescription = "description"
////        case publishedDate = "published_date"
////        case type
////        case imageLink = "image_link"
////        case comments
////    }
////}
//
//struct BlogList: Codable {
//    let id : Int
//    let title, location, description, publish_date: String
//   // let comments: [Comment]
//    
//}
//
//
//
//// MARK: - Comment
////struct Comment: Codable {
////    let id, userID: Int
////    let userName: String
////    let commentableID: Int
////    let commentableType, commentBody: String
////
////    enum CodingKeys: String, CodingKey {
////        case id
////        case userID = "user_id"
////        case userName = "user_name"
////        case commentableID = "commentable_id"
////        case commentableType = "commentable_type"
////        case commentBody = "comment_body"
////    }
////}
//
//struct Comment: Codable {
////    <#fields#>
//}
