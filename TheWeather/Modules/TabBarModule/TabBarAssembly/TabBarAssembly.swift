//
//  TabBarAssembly.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit

final class TabBarAssembly: ModuleAssembly {
    
    var view: UIViewController

    var presenter: ApplicationPresenterProtocol = ApplicationPresenter()
    
    private init() {
        view = UIViewController()
    }
    
    static func assembly(navigation: Bool = false) -> Self {
        let assembly = self.init()
        
        let view = TabBarViewController()
        
        assembly.view = view
        view.presenter = assembly.presenter

        guard navigation else { return assembly }
        
        let navigationController = UINavigationController(rootViewController: view)
        
        assembly.view = navigationController
        
        return assembly
    }
}
//  <+55.75578600,+37.61763300> +/- 5.00m (speed -1.00 mps / course -1.00) @ 5/25/23, 8:24:54 PM Georgia Standard Time
