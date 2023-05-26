//
//  MainPresenter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import Foundation
import Alamofire

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    var weatherData: Weather? { get }
    var searchData: String? { get set }
    func search()
}
//Raleigh
class MainPresenter {
    
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    
    private let dataStorage: DataStorage
    
    var weatherData: Weather?
    var searchData: String?
    
    init() {
        self.dataStorage = DataStorage.shared
        configure()
    }
}

extension MainPresenter {
    
    private func configure() {
        dataStorage.updatedDataCallBack = { [weak self] in
            guard let self = self else { return }
            self.updatedData()
        }
    }
    
   private func getDataFromStorage() {
        weatherData = dataStorage.currentWeatherData
    }
    
    private func updatedData() {
        getDataFromStorage()
        view?.updateData()
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func viewDidLoad() {
        updatedData()
    }
    
    func search() {
        guard let cityName = searchData else { return }
        let group = DispatchGroup()
        
        group.enter()
        fetchCurrentWeather(city: cityName) {
            group.leave()
        }
        
        group.enter()
        fetchDeylyWeather(city: cityName) {
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.updatedData()
        }
    }
    
    private func fetchCurrentWeather(city: String, completion: (() -> Void)? = nil) {
        getCurrentWeather(cityName: city) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                DispatchQueue.global().async {
                    self.dataStorage.currentWeatherData = success.data?.first
                }
                completion?()
            case .failure(let failure):
                print(failure.localizedDescription)
                self.router?.showError(errorType: .cityFoundError)
            }
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
                completion?()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

//TODO: - Build Request
extension MainPresenter {
    
    private func getCurrentWeather(cityName: String, completion: @escaping ((Result<WeatherResponse, AFError>) -> Void)) {
        let route = WeatherNetworkRouter.currentWeather(cityName: cityName)
        NetworkService.shared.performRequest(route: route, completion: completion)
    }
    
    private func getDeylyWeather(cityName: String, completion: @escaping ((Result<WeatherForecastResponse, AFError>) -> Void)) {
        let route = WeatherNetworkRouter.dailyWeather(cityName: cityName)
        NetworkService.shared.performRequest(route: route, completion: completion)
    }
}
