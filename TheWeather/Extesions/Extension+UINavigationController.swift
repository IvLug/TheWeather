//
//  Extension+UINavigationController.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit

extension UIViewController {
    
    private struct AssociatedKeys {
        static var navigationControllerTypeKey = "navigationControllerTypeKey"
    }
    
    var navigationControllerType: TabBarItemIndex {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.navigationControllerTypeKey) as? TabBarItemIndex ?? .none
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.navigationControllerTypeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
