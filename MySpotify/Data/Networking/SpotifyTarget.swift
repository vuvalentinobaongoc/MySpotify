//
//  UserTarget.swift
//  MVPExample
//
//  Created by Ngoc Vũ on 01/04/2022.
//

import Foundation
import Moya

enum SpotifyTarget: TargetType {
   
    case token(authenCode: String)
    /// Get my infomation
    case me
    case playList(_ userId: String)
    
    // MARK: TargetType
    
    var baseURL: URL {
        switch self {
        case .token(authenCode: _):
            return URL(string: AppConfig.spotifyAccountBaseUrl)!
        default:
           return URL(string: AppConfig.spotifyApiBaseUrl)!
        }
    }
    
    var path: String {
        switch self {
        case .token:
            return "token"
        case .me:
            return "/v1/me"
        case let .playList(userId):
            return  "/v1/users/\(userId)/playlists"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .token:
            return .post
        case .me:
            return .get
        case .playList(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .token(authenCode):
            let scopeAsString = Application.SpotifyStringScopes.joined(separator: " ")
            
            let query = [
                "client_id": Application.SpotifyClientId,
                "grant_type":"authorization_code",
                "code": authenCode,
                "redirect_uri" : Application.SpotifyRedirectUrl,
                "code_verifier": "", // not currently used
                "scope": scopeAsString,
            ]
            return .requestParameters(parameters: query, encoding: URLEncoding())
        case .me:
            return .requestPlain
        case .playList(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .token(authenCode: _):
            let spotifyAuthKey = "Basic \((Application.SpotifyClientId + ":" + Application.SpotifyClientSecret).data(using: .utf8)!.base64EncodedString())"
            return ["Authorization": spotifyAuthKey,
                    "Content-Type": "application/x-www-form-urlencoded"]
        default:
            return ["authorization": "Bearer \(AccountManager.shared.accessToken ?? "")"]
        }
    }
    
    var validationType: ValidationType {
        .successCodes
    }
}
