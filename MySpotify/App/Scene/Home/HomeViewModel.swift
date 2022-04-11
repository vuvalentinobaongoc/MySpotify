//
//  HomeViewModel.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 04/04/2022.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType {
    
    // MARK: - Input
    struct Input {
        let viewDidload: Driver<Void>
        let userAuthorized: Observable<Void>
    }
    
    // MARK: - Output
    struct Output {
        let myInfo: Driver<MyInfoWidget>
        let playList: Driver<[PlayListWidget]>
    }
   
    // MARK: - Rx
    private let bag = DisposeBag()
    private let triggerPlaylistCall = PublishSubject<User.UserID>()
    
    // MARK: - Dependency
    private let userUseCase: UserUseCase
    private let playListUseCase: PlayListUseCase
    
    init(userUseCase: UserUseCase = DIContainer.shared.resolve(type: UserUseCase.self)!,
         playListUseCase: PlayListUseCase = DIContainer.shared.resolve(type: PlayListUseCase.self)!) {
        self.userUseCase = userUseCase
        self.playListUseCase = playListUseCase
    }
    
    func transform(input: Input) -> Output {
        
        let myInfo: Driver<MyInfoWidget> = Observable.combineLatest(input.viewDidload.asObservable(),
                                                                    input.userAuthorized.asObservable())
            .flatMap {[weak self] _ -> Single<MyInfoWidget> in
                guard let self = self else {
                    return Observable.empty().asSingle()
                }
                return self.userUseCase.getMyInfomation()
            }
            .asDriver(onErrorJustReturn: .unknownWidget)
            .do(onNext: {[weak self] _ in
                self?.triggerPlaylistCall.onNext(AccountManager.shared.userId ?? "")
            })
        
        let playList = triggerPlaylistCall.flatMap {[weak self] userID -> Single<[PlayListWidget]> in
            guard let self = self else {
                return Observable.just([]).asSingle()
            }
            return self.playListUseCase.getPlayList(of: userID)
        }.asDriver(onErrorJustReturn: [])
        return Output(myInfo: myInfo, playList: playList)
    }
}
