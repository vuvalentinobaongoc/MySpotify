//
//  User+test.swift
//  MySpotifyTests
//
//  Created by Ngoc Vũ on 11/04/2022.
//

import Foundation
@testable import MySpotify
typealias UserMockableRepo = UserRepository

extension User {
    static let dummyUserID = UUID().uuidString
    static let dummyUser = User(displayName: "Ngoc Vu",
                                userId: UUID().uuidString,
                                images: [Images(url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-68BCIaW0Iiam8wgn9vWs3vcGMHtg1yMTBg&usqp=CAU")],
                                follower: Follower(total: 10))
    static let anotherDummyUser = User(displayName: "Somebody else",
                                       userId: UUID().uuidString,
                                       images: [],
                                       follower: Follower(total: 0))
}

extension TokenResponse {
    static let dummyToken = TokenResponse(refreshToken: UUID().uuidString,
                                          accessToken: UUID().uuidString,
                                          expiredIn: 3600)
}
