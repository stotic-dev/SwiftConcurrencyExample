//
//  SceneDelegate.swift
//  SwiftConcurrencyMvpExample
//
//  Created by 佐藤汰一 on 2025/04/05.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        let rootVc = RootViewController()
        let wrappedRootVc = UINavigationController(rootViewController: rootVc)
        window?.rootViewController = wrappedRootVc
        
        window?.makeKeyAndVisible()
    }
}

