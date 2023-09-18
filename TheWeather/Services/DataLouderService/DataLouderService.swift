//
//  DataLouderService.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation
import Alamofire

protocol DataLouderServiceDelegate: AnyObject {
    func dataDidLoad()
    func processingData(type: ProcessingDataType)
    func processingError(errorType: ErrorType)
}

final class DataLouderService {

    weak var delegate: DataLouderServiceDelegate?

    private let dataStorage: DataStorage

    init() {
        dataStorage = DataStorage.shared
    }
}

extension DataLouderService {

    func loadData(_ isUpdate: Bool = false, completion: @escaping((Bool) -> Void)) {

        if isUpdate && dataStorage.currentCity == nil {
            delegate?.processingData(type: .update)
            return
        }

        guard let cerrentCity = dataStorage.currentCity?.lowercased() else {
            delegate?.processingError(errorType: .locationError)
            return
        }

        let group = DispatchGroup()

        group.enter()
        fetchCurrentWeather(city: cerrentCity) {
            group.leave()
        }

        group.enter()
        fetchDeylyWeather(city: cerrentCity) {
            group.leave()
        }

        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            completion(true)
            print("true")
            self.delegate?.processingData(type: isUpdate ? .update : .api)

        }
    }
}

extension DataLouderService {

    private func fetchCurrentWeather(city: String, completion: (() -> Void)? = nil) {
        getCurrentWeather(cityName: city) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                DispatchQueue.global().async {
                    self.dataStorage.currentWeatherData = success.data?.first
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion?()
        }
    }

    private func fetchDeylyWeather(city: String, completion: (() -> Void)? = nil) {
        getDeylyWeather(cityName: city) { [weak self]  result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                DispatchQueue.global().async {
                    self.dataStorage.forecastData = success.data
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion?()
        }
    }
}

extension DataLouderService {

    private func getCurrentWeather(cityName: String, completion: @escaping ((Result<WeatherResponse, AFError>) -> Void)) {
        let route = WeatherNetworkRouter.currentWeather(cityName: cityName)
        NetworkService.shared.performRequest(route: route, completion: completion)
    }

    private func getDeylyWeather(cityName: String, completion: @escaping ((Result<WeatherForecastResponse, AFError>) -> Void)) {
        let route = WeatherNetworkRouter.dailyWeather(cityName: cityName)
        NetworkService.shared.performRequest(route: route, completion: completion)
    }
}
