//
//  MainRouter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

protocol MainRouterProtocol: AnyObject {
    
}

final class MainRouter {
    
    weak var view: MainViewProtocol?
}

extension MainRouter: MainRouterProtocol {
    
}
