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
    let addPresenter: ApplicationPresenter

    init(window: UIWindow = UIWindow()) {
        self.window = window
        addPresenter = ApplicationPresenter.shared
        configure()
    }
    
    private func configure() {
        addPresenter.callBack = { [weak self] in
            guard let self = self else { return }
            self.showMainFlow()
        }
    }
    
    func showRootScreen() {
        let mainModule = LaunchScreenAssembly.assembly().view
        window.rootViewController = mainModule
        window.makeKeyAndVisible()
    }

    func showMainFlow() {
        let module = TabBarAssembly.assembly()
        self.window.rootViewController = module.view
        self.window.makeKeyAndVisible()
    }
}
