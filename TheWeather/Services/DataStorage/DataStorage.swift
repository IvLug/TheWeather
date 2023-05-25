//
//  DataStorage.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation

final class DataStorage {
    
    static let shared: DataStorage = {
        let instance = DataStorage()
        return instance
    }()
    
    private init() {}
    
    var forecastData: WeatherForecastResponse?
    var currentWeatherData: WeatherResponse?

    var currentCity: String?
    
}
