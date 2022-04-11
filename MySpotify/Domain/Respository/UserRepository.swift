//
//  UserRepository.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 05/04/2022.
//

import Foundation
import RxSwift

protocol UserRepository {
    func fetchMyProfile() -> Observable<User>
    func requestToken() -> Observable<TokenResponse?>
}
