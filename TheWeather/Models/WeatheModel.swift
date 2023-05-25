//
//  WeatheModel.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation

struct WeatherResponse: Codable {
    var data: [Weather]?
}

struct Weather: Codable {
    var temp: Double?
    var city_name: String?
    var wind_speed: Double?
    var wind_cdir_full: String?
    var wind_cdir: String?
    var sunrise: String?
    var sunset: String?
    var timezone: String?
    var clouds: Int?
    var pod: String?
    var weather: WeatherDetail?
}
