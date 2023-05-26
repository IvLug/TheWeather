//
//  AppRouter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

protocol AppRouterProtocol {
    func showRootScreen()
    func showError(errorType: ErrorType)
}

final class AppRouter {
    
    private(set) var window: UIWindow
    let addPresenter: ApplicationPresenter

    init(window: UIWindow = UIWindow()) {
        self.window = window
        addPresenter = ApplicationPresenter.shared
        addPresenter.router = self
        configure()
        
        
    }
    
    private func configure() {
        addPresenter.callBack = { [weak self] in
            guard let self = self else { return }
            self.showMainFlow()
        }
    }
}

extension AppRouter: AppRouterProtocol {
    
    func showRootScreen() {
        let mainModule = LaunchScreenAssembly.assembly(navigation: true).view
        window.rootViewController = mainModule
        window.makeKeyAndVisible()
    }

    func showMainFlow() {
        addPresenter.isUpdate = true
        let module = TabBarAssembly.assembly()
        self.window.rootViewController = module.view
        self.window.makeKeyAndVisible()
    }
    
    func showError(errorType: ErrorType) {
        
         let view = getSelectedView()
        
        var cancelAction: ActionVoid?
        
        switch errorType {
        case .locationError:
            cancelAction = {  [weak self] _ in
                self?.showMainFlow()
            }
        default: break
        }
        
        view?.showAlert(
            title: errorType.error.localizedFailureReason,
            message: errorType.error.localizedDescription,
            okTitle: errorType.succeseButtonTitle,
            cancelTitle: errorType.cancelButtonTitle,
            okAction: { [weak self] action in
                switch errorType {
                case .apiDataEmpty:
                    self?.showMainFlow()
                case .locationError:
                    self?.showUserSettings()
                default: break
                }
            },
            cancelAction: cancelAction)
    }
    
    private func getSelectedView() -> View? {
        var view: View?
        
        if let navBar = self.window.rootViewController as? UINavigationController,
           var selectedView = navBar.topViewController as? View {
            view = selectedView
        } else if let tabBar = self.window.rootViewController as? TabBarViewController,
                  let selectedView = tabBar.currentController as? View {
            view = selectedView
        }
        
        return view
    }
    
    func showUserSettings() {
        guard let urlGeneral = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(urlGeneral)
    }
}
