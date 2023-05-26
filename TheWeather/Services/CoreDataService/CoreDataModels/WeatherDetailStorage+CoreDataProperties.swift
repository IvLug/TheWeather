//
//  WeatherDetailStorage+CoreDataProperties.swift
//  TheWeather
//
//  Created by Иван Луганцов on 26.05.2023.
//
//

import Foundation
import CoreData


extension WeatherDetailStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherDetailStorage> {
        return NSFetchRequest<WeatherDetailStorage>(entityName: "WeatherDetailStorage")
    }

    @NSManaged public var descriptions: String?
    @NSManaged public var icon: String?

}

extension WeatherDetailStorage : Identifiable {
    
    func castToModel() -> WeatherDetail {
        var model = WeatherDetail()
        model.icon = self.icon
        model.description = self.description
                
        return model
    }
}
