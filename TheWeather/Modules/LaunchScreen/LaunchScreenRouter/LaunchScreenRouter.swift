//
//  LaunchScreenRouter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

protocol LaunchScreenRouterProtocol: AnyObject {
    
}

final class LaunchScreenRouter {
    
    weak var view: LaunchScreenViewProtocol?
}

extension LaunchScreenRouter: LaunchScreenRouterProtocol {
    
}
