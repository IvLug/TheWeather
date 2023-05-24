//
//  ForecastPresenter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import Foundation

protocol ForecastPresenterProtocol: AnyObject {
    
}

class ForecastPresenter {
    
    weak var view: ForecastViewProtocol?
    var router: ForecastRouterProtocol?
}

extension ForecastPresenter: ForecastPresenterProtocol {
    
}
