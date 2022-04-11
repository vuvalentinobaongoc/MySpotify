//
//  RealPlayListRepository.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 05/04/2022.
//

import Foundation
import RxSwift
import Moya

struct RealPlayListRepository: PlayListRepository {
    
    // MARK: - Dependency
    private let provider: MoyaProvider<SpotifyTarget>
    init(provider: MoyaProvider<SpotifyTarget> = MoyaProvider(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])) {
        self.provider = provider
    }
    
    // MARK: - PlayListRepository
    func fetchPlayList(of userId: String) -> Observable<PlayLists> {
        return Observable.create { observer in
            self.provider.request(.playList(userId)) { (response: Result<Response, MoyaError>) in
                let result = response.decode(as: PlayLists.self)
                switch result {
                case let .failure(error):
                    observer.onError(error)
                case let.success(playlists):
                    observer.onNext(playlists)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}
