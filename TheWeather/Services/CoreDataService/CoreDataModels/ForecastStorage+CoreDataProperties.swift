//
//  ForecastStorage+CoreDataProperties.swift
//  TheWeather
//
//  Created by Иван Луганцов on 26.05.2023.
//
//

import Foundation
import CoreData

extension ForecastStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastStorage> {
        return NSFetchRequest<ForecastStorage>(entityName: "ForecastStorage")
    }

    @NSManaged public var datetime: String?
    @NSManaged public var sunrise_ts: Int64
    @NSManaged public var sunset_ts: Int64
    @NSManaged public var temp: Double
    @NSManaged public var ts: Int64
    @NSManaged public var wind_cdir: String?
    @NSManaged public var wind_cdir_full: String?
    @NSManaged public var wind_speed: Double
    @NSManaged public var weather: WeatherDetailStorage?

}

extension ForecastStorage : Identifiable {

    func castToModel() -> WeatherForecast {
        var model = WeatherForecast()

        model.temp = self.temp
        model.datetime = self.datetime
        model.wind_speed = self.wind_speed
        model.wind_cdir_full = self.wind_cdir_full
        model.wind_cdir = self.wind_cdir
        model.sunrise_ts = Int(self.sunrise_ts)
        model.sunset_ts = Int(self.sunset_ts)
        model.ts = Int(self.ts)

        var weather = WeatherDetail()
        weather.icon = self.weather?.icon
        weather.description = self.weather?.description

        model.weather = weather

        return model
    }
}
