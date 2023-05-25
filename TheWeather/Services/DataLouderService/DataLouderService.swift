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
}

final class DataLouderService {
    
    weak var delegate: DataLouderServiceDelegate?
        
    private let dataStorage: DataStorage
    
    init() {
        dataStorage = DataStorage.shared
    }
}

extension DataLouderService {
        
    func loadData(isUpdate: Bool = false, completion: (() -> Void)? = nil) {
       
        guard let cerrentCity = dataStorage.currentCity?.lowercased() else {
            completion?()
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
            completion?()
            guard !isUpdate else { return }
            self.delegate?.dataDidLoad()
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
                    self.dataStorage.currentWeatherData = success
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
                    self.dataStorage.forecastData = success
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            completion?()
        }
    }
}


//TODO: - Build Request
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
