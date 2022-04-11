//
//  RealUserRepository.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 05/04/2022.
//

import RxSwift
import Moya
import Foundation

struct RealUserRepository: UserRepository {
    // MARK: - Dependency
    private let provider: MoyaProvider<SpotifyTarget>
    
    init(provider: MoyaProvider<SpotifyTarget> = MoyaProvider(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])) {
        self.provider = provider
    }
    
    // MARK: - UserRepository
    func fetchMyProfile() -> Observable<User> {
        return Observable<User>.create { observer in
            self.provider.request(.me) { (response: Result<Response, MoyaError>) in
                let result = response.decode(as: User.self)
                switch result {
                case let .success(user):
                    AccountManager.shared.setUserId(user.userId)
                    observer.onNext(user)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create {}
        }
    }
    
    func requestToken() -> Observable<TokenResponse?> {
        guard let authenCode = AccountManager.shared.authenCode else {
            return .empty()
        }
        return Observable<TokenResponse?>.create { observer in
            self.provider.request(.token(authenCode: authenCode)) { (response: Result<Response, MoyaError>) in
                let result = response.decode(as: TokenResponse.self)
                switch result {
                case let .success(tokenResponse):
                    AccountManager.shared.setAccessToken(tokenResponse.accessToken)
                    AccountManager.shared.setRefreshToken(tokenResponse.refreshToken)
                    observer.onNext(tokenResponse)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
