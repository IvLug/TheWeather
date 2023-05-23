//
//  AppRouter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

protocol AppRouterType {
    func showRootScreen()
}

final class AppRouter: AppRouterType {
    private(set) var window: UIWindow

    init(window: UIWindow = UIWindow()) {
        self.window = window
    }

    func showRootScreen() {
        let mainModule = LaunchScreenAssembly.assembly(navigation: false).view
        
        let navigationController = UINavigationController(rootViewController: mainModule)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
