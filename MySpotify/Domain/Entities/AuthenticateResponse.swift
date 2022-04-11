//
//  AuthenticateResponse.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 07/04/2022.
//

import Foundation
struct AuthenticateResponse: Codable {
    let code: String
    
}

struct TokenResponse: Codable {
    let refreshToken: String
    let accessToken: String
    let expiredIn: Int
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case expiredIn = "expires_in"
    }
}
