//
//  WeatheModel.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation

struct WeatherResponse: Codable {
    var data : [Weather]?
}

struct Weather: Codable {
    let temp: Double?
    let city_name: String?
    let wind_spd: Double?
    let wind_cdir_full: String?
    let wind_cdir: String?
    let sunrise: String?
    let timezone: String?
    let clouds: Int?
    let weather: WeatherDetail?
}
