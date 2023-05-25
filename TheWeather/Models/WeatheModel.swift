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
    var temp: Double? = 17.2
    var cityName: String? = "Raleigh"
    var windSpeed: Double? = 1.34
    var windCdirFull: String? = "west-northwest"
    var windCdir: String? = "WNW"
    var sunrise: String? = "10:02"
    var sunset: String? = "20:04"
    var timezone: String? = "America/New_York"
    var clouds: Int? = 86
    var pod: String? = "d"
    var weather: WeatherDetail? = WeatherDetail()
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case windSpeed = "wind_speed"
        case windCdir = "wind_cdir"
        case windCdirFull = "wind_cdir_full"
    }
}
