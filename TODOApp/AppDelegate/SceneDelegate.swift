//
//  SceneDelegate.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 07/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: UserListCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowsScene)
        let navigationController = UINavigationController()

        window.rootViewController = navigationController
        coordinator = UserListCoordinator(presenter: navigationController)
        coordinator.start()

        self.window = window
        window.makeKeyAndVisible()
    }
}

