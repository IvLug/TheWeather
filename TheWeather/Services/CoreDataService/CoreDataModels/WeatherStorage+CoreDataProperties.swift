//
//  WeatherStorage+CoreDataProperties.swift
//  TheWeather
//
//  Created by Иван Луганцов on 26.05.2023.
//
//

import Foundation
import CoreData


extension WeatherStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherStorage> {
        return NSFetchRequest<WeatherStorage>(entityName: "WeatherStorage")
    }

    @NSManaged public var city_name: String?
    @NSManaged public var clouds: Int64
    @NSManaged public var pod: String?
    @NSManaged public var sunrise: String?
    @NSManaged public var sunset: String?
    @NSManaged public var temp: Double
    @NSManaged public var timezone: String?
    @NSManaged public var wind_cdir: String?
    @NSManaged public var wind_cdir_full: String?
    @NSManaged public var wind_speed: Double
    @NSManaged public var weather: WeatherDetailStorage?

}

extension WeatherStorage : Identifiable {

    func castToModel() -> Weather {
        var model = Weather()
        
        model.temp = self.temp
        model.city_name = self.city_name
        model.wind_speed = self.wind_speed
        model.wind_cdir_full = self.wind_cdir_full
        model.wind_cdir = self.wind_cdir
        model.sunrise = self.sunrise
        model.sunset = self.sunset
        model.timezone = self.timezone
        model.clouds = Int(self.clouds)
        model.pod = self.pod
        
        var weather = WeatherDetail()
        weather.icon = self.weather?.icon
        weather.description = self.weather?.descriptions
        
        model.weather = weather
        
        return model
    }
}
