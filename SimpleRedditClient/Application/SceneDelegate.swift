//
//  SceneDelegate.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 08/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var coordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            
            let window = UIWindow(windowScene: windowScene)

            // send window into our coordinator so that it can display view controllers
            coordinator = AppCoordinator(window: window, container: AppDIContainer.shared)

            // tell the coordinator to take over control
            coordinator.start()

            window.makeKeyAndVisible()
        }
    }
}

