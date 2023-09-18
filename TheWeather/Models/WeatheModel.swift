//
//  WeatheModel.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation
import CoreData

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

extension Weather {

    func caastToCoreData(context: NSManagedObjectContext) -> WeatherStorage {

        let model = WeatherStorage(context:context)

        model.temp = self.temp ?? 0
        model.city_name = self.city_name
        model.wind_speed = self.wind_speed ?? 0
        model.wind_cdir_full = self.wind_cdir_full
        model.wind_cdir = self.wind_cdir
        model.sunrise = self.sunrise
        model.sunset = self.sunset
        model.timezone = self.timezone
        model.clouds = Int64(self.clouds ?? 0)
        model.pod = self.pod

        let weather = WeatherDetailStorage(context:context)
        weather.icon = self.weather?.icon
        weather.descriptions = self.weather?.description

        model.weather = weather

        return model
    }
}
