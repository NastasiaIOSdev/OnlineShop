//
//  SceneDelegate.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 05.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var dependencies: IDependencies = Dependencies()
    private var coordinator: AppCoordinatorProtocol?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureScene(windowScene)
    }
    private func configureScene(_ windowScene: UIWindowScene) {
        let navController = UINavigationController()
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        self.coordinator = AppCoordinator(navController, dependencies: dependencies)
        self.coordinator?.start()
    }
}
