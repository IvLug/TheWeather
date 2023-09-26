//
//  DataStorage.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation
import CoreData

final class DataStorage {

    static let shared: DataStorage = {
        let instance = DataStorage()
        return instance
    }()

    private let storage = StorageManager.shared

    private var context: NSManagedObjectContext {
        storage.viewContext
    }

    private init() {}

    var updatedDataCallBack: EmptyClosure?

    var forecastData: [WeatherForecast]?
    var currentWeatherData: Weather?
    var currentCity: String?
}

extension DataStorage {

    func updatedData() {
        updateStorageData()
        updatedDataCallBack?()
    }
}

extension DataStorage {

    // MARK: Fetch
    func fetchAllData(completion: EmptyClosure? = nil) {
        let group = DispatchGroup()

        group.enter()
        fetchWeather {
            group.leave()
        }

        group.enter()
        fetchForecast {
            group.leave()
        }

        group.notify(queue: .main) {
            completion?()
        }
    }

    func fetchWeather(callback: EmptyClosure) {
        fetchWaterRequest { result in
            switch result {
            case .success(let data):
                self.currentWeatherData = data.first?.castToModel()
            case .failure(let error):
                print(error)
            }
            callback()
        }
    }

    func fetchForecast(callback: EmptyClosure) {
        fetchForecastRequest { result in
            switch result {
            case .success(let data):
                self.forecastData = data.map({ $0.castToModel() })
            case .failure(let error):
                print(error)
            }
            callback()
        }
    }

   // MARK: Save
    func saveAllDate() {
        setWeatherToStorage()
        setForecastToStorage()
    }

   func setWeatherToStorage() {
        guard let currentWeatherModel = currentWeatherData else { return }
        let weather = currentWeatherModel.caastToCoreData(context: context)

        storage.save(model: weather)
    }

    func setForecastToStorage() {
        guard let forecastDataModel = forecastData else { return }

        forecastDataModel.forEach { model in
            let forecas = model.caastToCoreData(context: context)
            storage.save(model: forecas)
        }
    }

    // MARK: Edit
    func updateStorageData() {
        editWeather()
        editForecast()
    }

    func editWeather() {
        guard let currentWeatherModel = currentWeatherData else { return }
        let model = currentWeatherModel.caastToCoreData(context: context)
        storage.edit(model: model)
    }

    func editForecast() {
        guard let forecastDataModel = forecastData else { return }

        forecastDataModel.forEach { model in
            let forecas = model.caastToCoreData(context: context)
            storage.edit(model: forecas)
        }
    }

// MARK: Clear
    func clerCoreData() {
        forecastData = nil
        currentWeatherData = nil
        storage.clearCoreData()
    }
}

// MARK: FetchRequestBuild
extension DataStorage {

    private func fetchWaterRequest(completion: (Result<[WeatherStorage], Error>) -> Void) {
        storage.fetchData(completion: completion)
    }

    private func fetchForecastRequest(completion: (Result<[ForecastStorage], Error>) -> Void) {
        storage.fetchData(completion: completion)
    }
}
