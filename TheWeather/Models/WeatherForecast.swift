//
//  WeatherForecast.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation


struct WeatherForecastResponse: Codable {
    var city_name: String?
    var timezone: String?
    var data: [WeatherForecast]?
}

struct WeatherForecast: Codable {
    var temp: Double?
    var datetime: String?
    var wind_speed: Double?
    var wind_cdir_full: String?
    var wind_cdir: String?
    var weather: WeatherDetail?
    var sunrise_ts: Int?
    var sunset_ts: Int?
    var ts: Int?
}
