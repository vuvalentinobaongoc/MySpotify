//
//  User.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 05/04/2022.
//

import Foundation

struct User: Codable {
    
    let displayName: String
    let userId: UserID
    let images: [Images]
    let follower: Follower
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case userId = "id"
        case images = "images"
        case follower = "followers"
    }
    
    // MARK: - Nest object
    
    struct Images: Codable {
        let url: String
        enum CodingKeys: String, CodingKey {
            case url
        }
    }
    
    struct Follower: Codable {
        let total: Int
    }
    typealias UserID = String
}



