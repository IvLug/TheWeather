//
//  MainPresenter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    
}

class MainPresenter {
    
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
}

extension MainPresenter: MainPresenterProtocol {
    
}
