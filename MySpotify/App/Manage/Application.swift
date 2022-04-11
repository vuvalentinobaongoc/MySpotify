//
//  Application.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 05/04/2022.
//

import Foundation
import UIKit
import URLNavigator

protocol ApplicationDelegate: AnyObject {
}

struct Application {
    weak var delegate: ApplicationDelegate?
    static func buildDelegate() -> SceneDelegateType {
        return CompositeSceneDelegate(sceneDelegates: [
            StartupSceneDelegate(),
            SpotifySceneDelegate()
        ])
    }
    
    static let SpotifyRedirectUrl = "nicolas.myspotify://"
    static let SpotifyClientSecret = ""
    static let SpotifyClientId = ""
    static let SpotifyAccessTokenKey = "access-token-key"
    static let SpotifyScopes: SPTScope = [
        .userReadEmail, .userReadPrivate,
        .userReadPlaybackState, .userModifyPlaybackState, .userReadCurrentlyPlaying,
        .streaming, .appRemoteControl,
        .playlistReadCollaborative, .playlistModifyPublic, .playlistReadPrivate, .playlistModifyPrivate,
        .userLibraryModify, .userLibraryRead,
        .userTopRead, .userReadPlaybackState, .userReadCurrentlyPlaying,
        .userFollowRead, .userFollowModify,
    ]
    static let SpotifyStringScopes = [
        "user-read-email", "user-read-private",
        "user-read-playback-state", "user-modify-playback-state", "user-read-currently-playing",
        "streaming", "app-remote-control",
        "playlist-read-collaborative", "playlist-modify-public", "playlist-read-private", "playlist-modify-private",
        "user-library-modify", "user-library-read",
        "user-top-read", "user-read-playback-position", "user-read-recently-played",
        "user-follow-read", "user-follow-modify",
    ]
}
