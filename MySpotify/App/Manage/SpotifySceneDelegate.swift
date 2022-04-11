//
//  SpotifyManager.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 06/04/2022.
//

import Foundation
import Moya
final class SpotifySceneDelegate: SceneDelegateType {
    
    private (set) lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: Application.SpotifyClientId, redirectURL: URL(string: Application.SpotifyRedirectUrl)!)

        configuration.tokenSwapURL = URL(string: "http://localhost:1234/swap")
        configuration.tokenRefreshURL = URL(string: "http://localhost:1234/refresh")
        return configuration
    }()
    
    private (set) lazy var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: configuration, delegate: self)
        return manager
    }()
    
    private (set) lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let scope: SPTScope = [.appRemoteControl, .playlistReadPrivate]
        sessionManager.initiateSession(with: scope, options: .clientOnly)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        guard let parameters = self.appRemote.authorizationParameters(from: url) else {
            return
        }
        guard let data = try? JSONSerialization.data(withJSONObject: parameters) else {
            return
        }
        guard let authenticateResponse = try? JSONDecoder().decode(AuthenticateResponse.self, from: data) else {
            return
        }
        AccountManager.shared.setAuthenCode(authenticateResponse.code)
        NotificationCenter.default.post(name: .userAuthorized, object: authenticateResponse.code)
    }
}

extension SpotifySceneDelegate: SPTSessionManagerDelegate {
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
//        self.delegate?.presentAlertController(title: "Authorization Failed", message: error.localizedDescription, bundle: "")
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
//        self.delegate?.presentAlertController(title: "Session Renewed", message: session.description, bundle: "")
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        appRemote.connectionParameters.accessToken = session.accessToken
        appRemote.connect()
    }
    func sessionManager(manager: SPTSessionManager, shouldRequestAccessTokenWith code: String) -> Bool {
        return true
    }
}

extension SpotifySceneDelegate: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        appRemote.playerAPI?.delegate = self
        appRemote.playerAPI?.subscribe(toPlayerState: { (success, error) in
            if let error = error {
                print("Error subscribing to player state:" + error.localizedDescription)
            }
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
    }
}

extension SpotifySceneDelegate: SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        
    }
}
