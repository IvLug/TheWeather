//
//  LaunchScreenPresenter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import Foundation

protocol LaunchScreenPresenterProtocol: AnyObject {
    
}

final class LaunchScreenPresenter {
    
    weak var view: LaunchScreenViewProtocol?
    var router: LaunchScreenRouterProtocol?
    
}

extension LaunchScreenPresenter: LaunchScreenPresenterProtocol {
    
}
