//
//  ForecastAssembly.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

final class ForecastScreenAssembly: ModuleAssembly {
    
    var view: UIViewController
    
    lazy var presenter = ForecastPresenter()
    lazy var router = ForecastRouter()
    
    private init() {
        view = UIViewController()
    }
    
    static func assembly(navigation: Bool = false) -> Self {
        let assembly = self.init()
        
        let view = ForecastViewController()
        
        assembly.view = view
        
        view.presenter = assembly.presenter
                
        assembly.presenter.view = view
        assembly.presenter.router = assembly.router
        
        assembly.router.view = view

        guard navigation else { return assembly }
        
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.navigationControllerType = .main
        
        assembly.view = navigationController
        
        return assembly
    }
}
