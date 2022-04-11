//
//  PlayList.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 05/04/2022.
//

import Foundation

struct PlayList: Codable {
    let id: String
    let name: String
    let description: String
    let uri: String
}

extension PlayList: Equatable {
    static func  == (lhs: PlayList, rhs: PlayList) -> Bool {
        return lhs.id == rhs.id
    }
}

struct PlayLists: Codable {
    let items: [PlayList]
    let total: Int
    let limit: Int
    let offset: Int
    
    var count: Int {
        return items.count
    }
}

extension PlayLists: Equatable {
    static func == (lhs: PlayLists, rhs: PlayLists) -> Bool {
        return lhs.items == rhs.items
    }
}
