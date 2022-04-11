//
//  AccountManager.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 05/04/2022.
//

import Foundation

final class AccountManager: UserDefaultProps {
    private let queue = DispatchQueue(label: "AccountManagerQueue",
                                      qos: .userInitiated,
                                      attributes: .concurrent)
    private init() {}
    
    static let shared = AccountManager()
    
    private var _userId: String? = nil
    
    func setUserId(_ id: String) {
        queue.async(flags: .barrier, execute: {
            self._userId = id
            NotificationCenter.default.post(name: .userIDDidUpdate, object: nil)
        })
    }
    
    func setAuthenCode(_ code: String) {
        UserDefaults.standard.set(code, forKey: UserDefaultKey.authenCode.rawValue)
    }
    
    func setAccessToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultKey.accessToken.rawValue)
    }
    
    func setRefreshToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultKey.refreshToken.rawValue)
    }
    
    var userId: String? {
        queue.sync {
            return _userId
        }
    }
    
    var authenCode: String? {
        return UserDefaults.standard.string(forKey: UserDefaultKey.authenCode.rawValue)
    }
    
    var accessToken: String? {
        return UserDefaults.standard.string(forKey: UserDefaultKey.accessToken.rawValue)
    }
    
    var refreshToken: String? {
        return UserDefaults.standard.string(forKey: UserDefaultKey.refreshToken.rawValue)
    }
}
