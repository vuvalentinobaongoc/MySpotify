//
//  UserUseCase.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 05/04/2022.
//

import Foundation
import RxSwift

protocol UserUseCase {
    func getMyInfomation() -> Single<MyInfoWidget>
}

struct MyUserUseCase: UserUseCase {
    // MARK: - Dependency
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    // MARK: - UserUseCase
    func getMyInfomation() -> Single<MyInfoWidget> {
        return self.repository.requestToken()
            .catchAndReturn(nil)
            .asSingle()
            .flatMap { res -> Single<MyInfoWidget> in
                guard let res = res, !res.accessToken.isEmpty else {
                    return .just(.unknownWidget)
                }
                return self.repository.fetchMyProfile().map { user -> MyInfoWidget in
                    return MyInfoWidget.transform(from: user)
                }
                .catchAndReturn(.unknownWidget)
                .asSingle()
            }
    }
}
