//
//  WeatherForecast.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation

struct WeatherForecastResponse: Codable {
    var data: [WeatherForecast]?
}

struct WeatherForecast: Codable {
    var temp: Double?
    var datetime: String?
    var weather: WeatherDetail?
}
