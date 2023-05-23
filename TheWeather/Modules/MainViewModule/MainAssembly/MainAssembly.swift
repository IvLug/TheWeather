//
//  MainAssembly.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

final class MainScreenAssembly: ModuleAssembly {
    
    var view: UIViewController
    
    lazy var presenter = MainPresenter()
    lazy var router = MainRouter()
    
    private init() {
        view = UIViewController()
    }
    
    static func assembly(navigation: Bool = true) -> Self {
        let assembly = self.init()
        
        let view = MainViewController()
        
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
