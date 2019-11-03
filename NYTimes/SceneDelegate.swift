//
//  SceneDelegate.swift
//  NYTimes
//
//  Created by Eduard Galchenko on 11/3/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    @available(iOS 13.0, *)
    @available(iOS 13.0, *)
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let mostEmailedViewController = MostEmailedViewController()
        let mostViewedViewController  = MostViewedViewController()
        let mostSharedViewController  = MostSharedViewController()
        
        let tabBarController = UITabBarController()
        
        tabBarController.setViewControllers([mostEmailedViewController,
                                             mostViewedViewController,
                                             mostSharedViewController],
                                            animated: true)
        
        tabBarController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        window?.rootViewController = UINavigationController(rootViewController: tabBarController)
        window?.makeKeyAndVisible()
    }
    
}

