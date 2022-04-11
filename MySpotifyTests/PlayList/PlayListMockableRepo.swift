//
//  PlayListMockableRepo.swift
//  MySpotifyTests
//
//  Created by Ngoc Vũ on 11/04/2022.
//

import Foundation
@testable import MySpotify
typealias PlayListMockableRepo = PlayListRepository

extension PlayList {
    static func dummyPlayList(from id: String) -> PlayList {
        return PlayList(id: id,
                        name: "Test playlist",
                        description: "Playlist for testing",
                        uri: "")
    }
}

extension PlayLists {
    static let dummyIdentifiers = (0 ..< 10).map { _ in UUID().uuidString }
    static var dummyPlayLists: PlayLists {
        let dummyItems = dummyIdentifiers.map { PlayList.dummyPlayList(from: $0)}
        return PlayLists(items: dummyItems,
                         total: dummyItems.count,
                         limit: dummyItems.count,
                         offset: 0)
    }
}

extension PlayListWidget {
}
