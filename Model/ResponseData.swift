//
//  ResponseData.swift
//  apiTest
//
//  Created by Maruf Khan on 26/5/21.
//


import Foundation


let url = "https://genocide.misfit-test.com//api/v1/home_pages/land"
// MARK: - ResponseDatum
struct ResponseDatum: Codable {
    let banners: [Banner]?
    let archieves: [Archieve]?
    let museum_blogs: [MuseumBlog]?
    let events: [Event]?
    let notices: [Notice]?
    let about_us: [AboutUs]?
    let galleries: [Banner]?

    enum CodingKeys: String, CodingKey {
        case banners, archieves
        case museum_blogs
        case events, notices
        case about_us
        case galleries
    }
}

// MARK: - AboutUs
struct AboutUs: Codable {
    let id: Int
    let name, designation, description: String
    let facebook_link: String
    let twitter_link, youtube_link, linkedin_link, instagram_link: String
    let image_link: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case designation
        case description
        case facebook_link
        case twitter_link
        case youtube_link
        case linkedin_link
        case instagram_link
        case image_link
    }
}

// MARK: - Archieve
struct Archieve: Codable {
    let id: Int
    let title: String
    let video_url: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case video_url
    }
}

// MARK: - Banner
struct Banner: Codable {
    let id: Int
    let title, image_type: String
    let image_link: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case image_type
        case image_link
    }
}

// MARK: - Event
struct Event: Codable {
    let id: Int
    let title, category, start_date, end_date: String
    let description, location: String
    let cover_image: String

    enum CodingKeys: String, CodingKey {
        case id, title, category
        case start_date
        case end_date
        case description
        case location
        case cover_image
    }
}

// MARK: - MuseumBlog
struct MuseumBlog: Codable {
    let id: Int
    let title, location, description, published_date: String
    let type: String
    let image_link: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, title, location
        case description
        case published_date
        case type
        case image_link
        case comments
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id, user_id: Int
    let user_name: String
    let commentable_id: Int
    let commentable_type, comment_body: String

    enum CodingKeys: String, CodingKey {
        case id
        case user_id
        case user_name
        case commentable_id
        case commentable_type
        case comment_body
    }
}

// MARK: - Notice
struct Notice: Codable {
    let id: Int
    let title: String
    let source: String
    let release_date, notice_type: String
    let pdf_link: String
    let coverage_link: String?
    let preview_image: String

    enum CodingKeys: String, CodingKey {
        case id, title, source
        case release_date
        case notice_type
        case pdf_link
        case coverage_link
        case preview_image
    }
}


typealias ResponseData = [ResponseDatum]



