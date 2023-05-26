//
//  View.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

protocol View: UIViewController {}

enum TypeScreen {
    case fullScreen
    case halfScreen
    case tipScreen(height: CGFloat)
}

extension View {
    
    typealias EmptyVoid = () -> Void
    typealias ActionVoid = (_ action: UIAlertAction) -> Void
    
    @discardableResult
    func showModule<T: ModuleAssembly>(_ module: T.Type,
                                       modally: Bool = false,
                                       typeScreen: TypeScreen? = nil,
                                       navigation: Bool = false,
                                       animated: Bool = false,
                                       completion: EmptyVoid? = nil) -> T {
        let module = T.assembly(navigation: navigation)
        switch typeScreen {
        case .fullScreen:
            module.view.modalPresentationStyle = .fullScreen
            module.view.isModalInPresentation = true
        default:
            break
        }
        guard modally else {
            navigationController?.pushViewController(module.view, animated: animated)
            return module
        }
        navigationController?.present(module.view, animated: animated, completion: completion)
        return module
    }
    
    func dismiss(animated: Bool = false,_ comletion: EmptyVoid? = nil) {
        navigationController?.dismiss(animated: animated, completion: comletion)
    }
    
    func popModule(animated: Bool = false) {
        navigationController?.popViewController(animated: animated)
    }
    
    func push(animated: Bool = false, _ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    @discardableResult
    func presentOverFullScreen<T: ModuleAssembly>(_ module: T.Type,
                                                  animated: Bool = false,
                                                  navigation: Bool = false,
                                                  completion: EmptyVoid? = nil) -> T {
        let module = T.assembly(navigation: navigation)
        module.view.modalPresentationStyle = .fullScreen
        navigationController?.present(module.view, animated: animated, completion: completion)
        return module
    }
    
    func presentInfoAlert(title: String?, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel)
        alert.addAction(okAction)
        navigationController?.present(alert, animated: true)
    }
    
    func showAlert(title: String?,
                   message: String? = nil,
                   okTitle: String = "Хорошо",
                   cancelTitle: String = "Закрыть",
                   okAction: ActionVoid?,
                   cancelAction: ActionVoid? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okAction)       
       
        alert.addAction(okAction)
        
        guard cancelAction != nil else {
            navigationController?.present(alert, animated: true)
            return
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .destructive, handler: cancelAction)
        alert.addAction(cancelAction)
        navigationController?.present(alert, animated: true)
    }
}
