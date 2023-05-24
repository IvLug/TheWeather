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
        let mainModule = LaunchScreenAssembly.assembly().view
        
        window.rootViewController = mainModule
        window.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            mainModule.setRootModule(TabBarAssembly.self)
        })
    }
}
