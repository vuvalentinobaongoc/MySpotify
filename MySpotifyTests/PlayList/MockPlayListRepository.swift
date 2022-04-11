//
//  MockPlayListRepository.swift
//  MySpotifyTests
//
//  Created by Ngoc Vũ on 11/04/2022.
//

import Foundation
import RxSwift
@testable import MySpotify
    
struct UnhappyMockPlayListRepository: PlayListMockableRepo {
    func fetchPlayList(of userId: String) -> Observable<PlayLists> {
        return .error(DataError.expiredToken)
    }
}

struct MockPlayListRepository: PlayListMockableRepo {
    func fetchPlayList(of userId: String) -> Observable<PlayLists> {
        let dummyPlayLists = PlayLists.dummyPlayLists
        return .just(dummyPlayLists)
    }
    
}
