//
//  AudioList.swift
//  apiTest
//
//  Created by Maruf Khan on 1/6/21.
//

import Foundation

// MARK: - AudioListElement
struct AudioList: Codable {
    let id: Int
    let title, description: String
    let imageLink, audioLink: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case description
        case imageLink
        case audioLink
    }
}

