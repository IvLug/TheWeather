//
//  MainRouter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

protocol ForecastRouterProtocol: AnyObject {

}

final class ForecastRouter {

    weak var view: ForecastViewProtocol?
}

extension ForecastRouter: ForecastRouterProtocol {}
