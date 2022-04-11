//
//  PlayListUseCase.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 05/04/2022.
//

import Foundation
import RxSwift

protocol PlayListUseCase {
    /// - Parameters:
    ///     - userId: identify of user get from User Repository
    func getPlayList(of userId: String) -> Single<[PlayListWidget]>
}

struct MyPlayListUseCase: PlayListUseCase {
    
    // MARK: - Dependency
    let repository: PlayListRepository
    
    init(repository: PlayListRepository = RealPlayListRepository()) {
        self.repository = repository
    }
    
    // MARK: - UserUseCase
    func getPlayList(of userId: String) -> Single<[PlayListWidget]> {
        return self.repository.fetchPlayList(of: userId).map { playlists in
            return playlists.items.map { PlayListWidget(name: $0.name, id: $0.id)}
        }.asSingle()
    }
}
