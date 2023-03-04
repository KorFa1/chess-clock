//
//  SceneDelegate.swift
//  ChessClock
//
//  Created by Кирилл Софрин on 25.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let RootViewController = MainMenuViewController()
        let navigation = UINavigationController(rootViewController: RootViewController)
        navigation.isNavigationBarHidden = true
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        self.window = window
    }
}

