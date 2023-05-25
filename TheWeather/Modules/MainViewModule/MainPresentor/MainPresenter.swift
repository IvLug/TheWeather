//
//  MainPresenter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    var weatherData: Weather? { get }
    var forecastWeatherData: [WeatherForecast] { get }
}

class MainPresenter {
    
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    
    private let dataStorage: DataStorage
    
    var weatherData: Weather?
    var forecastWeatherData: [WeatherForecast] = []
    
    init() {
        self.dataStorage = DataStorage.shared
    }
}

extension MainPresenter {
    
    func getDataFromStorage() {
        weatherData = Weather() // dataStorage.currentWeatherData?.data?.first
        forecastWeatherData = dataStorage.forecastData?.data?.compactMap({ $0 }) ?? []
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func viewDidLoad() {
        getDataFromStorage()
        view?.updateData()
    }
}
