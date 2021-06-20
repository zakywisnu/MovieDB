//
//  SceneDelegate.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var homeNavigationController: UINavigationController!
    var popularNavigationController: UINavigationController!
    var favoriteNavigationController: UINavigationController!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        let tabBarController = UITabBarController()
        homeNavigationController = UINavigationController.init(rootViewController: HomeViewController(viewModel: HomeViewModel(homeUseCase: Injection.init().provideHome())))
        popularNavigationController = UINavigationController.init(rootViewController: PopularViewController())
        favoriteNavigationController = UINavigationController.init(rootViewController: FavoriteViewController())
        tabBarController.viewControllers = [homeNavigationController, popularNavigationController, favoriteNavigationController]
        let homeItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)
        let popularItem = UITabBarItem(title: nil, image: UIImage(systemName: "rosette"), tag: 1)
        let favoriteItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), tag: 2)
        homeNavigationController.tabBarItem = homeItem
        popularNavigationController.tabBarItem = popularItem
        favoriteNavigationController.tabBarItem = favoriteItem
        UITabBar.appearance().tintColor = UIColor(red: 255/255.0, green: 209/255.0, blue: 48/255.0, alpha: 1.0)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        UITabBar.appearance().backgroundColor = UIColor(red: 32/255.0, green: 33/255.0, blue: 35/255.0, alpha: 1.0)
        
        window?.windowScene = windowScene
        let viewController = tabBarController // Handle Develop Here
        let navigationBar = UINavigationController(rootViewController: viewController)
        navigationBar.isNavigationBarHidden = true
        window?.rootViewController = navigationBar
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

