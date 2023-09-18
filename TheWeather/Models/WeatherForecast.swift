//
//  WeatherForecast.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation
import CoreData

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

extension WeatherForecast {

    func caastToCoreData(context: NSManagedObjectContext) -> ForecastStorage {
        let model = ForecastStorage(context: context)

        model.temp = self.temp ?? 0
        model.datetime = self.datetime
        model.wind_speed = self.wind_speed ?? 0
        model.wind_cdir_full = self.wind_cdir_full
        model.wind_cdir = self.wind_cdir
        model.sunrise_ts = Int64(sunrise_ts ?? 0)
        model.sunset_ts = Int64(sunset_ts ?? 0)
        model.ts = Int64(ts ?? 0)

        let weather = WeatherDetailStorage(context: context)
        weather.icon = self.weather?.icon
        weather.descriptions = self.weather?.description

        model.weather = weather

        return model
    }
}
