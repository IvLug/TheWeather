//
//  ForecastPresenter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import Foundation

protocol ForecastPresenterProtocol: AnyObject {
    func viewDidLoad()
    var forecastWeatherData: [WeatherForecast] { get }
}

class ForecastPresenter {
    
    weak var view: ForecastViewProtocol?
    var router: ForecastRouterProtocol?
    
    private let dataStorage: DataStorage
    
    var forecastWeatherData: [WeatherForecast] = []
    
    init() {
        self.dataStorage = DataStorage.shared
    }
}

extension ForecastPresenter {
    
    func getDataFromStorage() {
        forecastWeatherData = dataStorage.forecastData?.data ?? []
    }
}

extension ForecastPresenter: ForecastPresenterProtocol {
    
    func viewDidLoad() {
        getDataFromStorage()
        view?.updateData()
    }
}
