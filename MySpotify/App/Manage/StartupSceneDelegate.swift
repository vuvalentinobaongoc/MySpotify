//
//  InitialRootControllerCommand.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 06/04/2022.
//

import Foundation
final class StartupSceneDelegate: SceneDelegateType {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.registerDependency(enableTest: false)
        self.initRoot(with: windowScene.keyWindow)
    }
    
    private func initRoot(with window: UIWindow?) {
        let vc = HomeBuilder.buildHome()
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
    }
    
    private func registerDependency(enableTest: Bool) {
        let container = DIContainer.shared
        container.register(type: UserRepository.self) { _ in
            return RealUserRepository()
        }
        
        container.register(type: PlayListRepository.self) { _ in
            return RealPlayListRepository()
        }
        
        container.register(type: PlayListUseCase.self) { container in
            return MyPlayListUseCase(repository: container.resolve(type: PlayListRepository.self)!)
        }
        container.register(type: UserUseCase.self) { container in
            return MyUserUseCase(repository: container.resolve(type: UserRepository.self)!)
        }
    }
}
