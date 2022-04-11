//
//  PlayListWidget.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 04/04/2022.
//

import Foundation

struct PlayListWidget: Equatable {
    let name: String
    let id: String
    
    
    static func == (rhs: PlayListWidget, lhs: PlayListWidget) -> Bool {
        return rhs.id == lhs.id
    }
}
