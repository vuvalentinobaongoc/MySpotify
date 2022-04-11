//
//  Command.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 06/04/2022.
//

import Foundation
typealias SceneDelegateType = UIResponder & UISceneDelegate

final class CompositeSceneDelegate: SceneDelegateType {
    private let sceneDelegates: [SceneDelegateType]
    
    init(sceneDelegates: [SceneDelegateType]) {
        self.sceneDelegates = sceneDelegates
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.sceneDelegates.forEach { $0.scene?(scene, willConnectTo: session, options: connectionOptions)}
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        self.sceneDelegates.forEach { $0.scene?(scene, openURLContexts: URLContexts)}
    }
    
}
