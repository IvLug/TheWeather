//
//  WeatherForecast.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation


struct WeatherForecastResponse: Codable {
    var cityName: String? = "Raleigh"
    var data: [WeatherForecast]?
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
    }
}

struct WeatherForecast: Codable {
    var temp: Double? = 17.2
    var datetime: String? = "2019-03-04:17"
    var windSpeed: Double? = 1.34
    var windCdirFull: String? = "west-northwest"
    var windCdir: String? = "WNW"
    var weather: WeatherDetail?
    var sunrise_ts: Int? = 1530331260
    var sunset_ts: Int = 946742640
    
    enum CodingKeys: String, CodingKey {
        case windSpeed = "wind_speed"
        case windCdir = "wind_cdir"
        case windCdirFull = "wind_cdir_full"
    }
}
