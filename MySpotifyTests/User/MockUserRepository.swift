//
//  MockUserRepository.swift
//  MySpotifyTests
//
//  Created by Ngoc Vũ on 07/04/2022.
//

import Foundation
import RxSwift
@testable import MySpotify
    
struct UnhappyMockUserRepository: UserMockableRepo {
    func requestToken() -> Observable<TokenResponse?> {
        return .error(DataError.network("Network error cannot request url!"))
    }
    
    func fetchMyProfile() -> Observable<User> {
        return .error(DataError.unknown)
    }
}

struct MockUserRepository: UserMockableRepo {
    func requestToken() -> Observable<TokenResponse?> {
        return .just(.dummyToken)
    }
    
    func fetchMyProfile() -> Observable<User> {
        return .just(.dummyUser)
    }
}
