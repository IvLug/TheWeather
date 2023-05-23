//
//  LaunchScreenAssembly.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

final class LaunchScreenAssembly: ModuleAssembly {
    
    var view: UIViewController
    
    lazy var presenter = LaunchScreenPresenter()
    lazy var router = LaunchScreenRouter()
    
    private init() {
        view = UIViewController()
    }
    
    static func assembly(navigation: Bool = true) -> Self {
        let assembly = self.init()
        
        let view = LaunchScreenView()
        
        assembly.view = view
        
        view.presenter = assembly.presenter
                
        assembly.presenter.view = view
        assembly.presenter.router = assembly.router
        
        assembly.router.view = view

        guard navigation else { return assembly }
        
        let navigationController = UINavigationController(rootViewController: view)
        
        assembly.view = navigationController
        
        return assembly
    }
}
