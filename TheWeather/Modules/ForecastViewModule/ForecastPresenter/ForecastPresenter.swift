//
//  ForecastPresenter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import Foundation

protocol ForecastPresenterProtocol: AnyObject {
    func viewWillAppear()
    var weatherData: Weather? { get }
    var forecastWeatherData: [WeatherForecast] { get }
}

class ForecastPresenter {

    weak var view: ForecastViewProtocol?
    var router: ForecastRouterProtocol?

    private let dataStorage: DataStorage

    var weatherData: Weather?
    var forecastWeatherData: [WeatherForecast] = []

    init() {
        self.dataStorage = DataStorage.shared
    }
}

extension ForecastPresenter {

    func getDataFromStorage() {
        forecastWeatherData = (dataStorage.forecastData ?? [])
        weatherData = dataStorage.currentWeatherData
    }

    func testTrue() -> Bool {
        return false
    }
}

extension ForecastPresenter: ForecastPresenterProtocol {

    func viewWillAppear() {
        getDataFromStorage()
        view?.updateData()
    }
}
