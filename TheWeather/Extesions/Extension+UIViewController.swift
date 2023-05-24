//
//  Extension+UIViewController.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

extension UIViewController {
    
    @discardableResult
    func setRootModule<T: ModuleAssembly>(_ module: T.Type) -> T {
        let module = T.assembly(navigation: false)
        UIApplication.setRootViewController(module.view)
        return module
    }
}
