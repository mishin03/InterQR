//
//  SceneDelegate.swift
//  InterQR
//
//  Created by Илья Мишин on 04.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        var window = UIWindow(windowScene: windowScene)

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene

        self.window = UIWindow(windowScene: windowScene)

        let vc = MyDoorsViewController()

        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
}
