//
//  File.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 07/04/2022.
//

import Foundation
enum UserDefaultKey: String {
    case authenCode
    case accessToken
    case refreshToken
}

protocol UserDefaultProps where Self: AccountManager {
    func setAuthenCode(_ code: String)
    
    func setAccessToken(_ token: String)
    
    func setRefreshToken(_ token: String)
    
    func setUserId(_ id: String)
    
    var authenCode: String? { get }
    
    var accessToken: String? { get }
    
    var refreshToken: String? { get }
    
    var userId: String? { get }
}
