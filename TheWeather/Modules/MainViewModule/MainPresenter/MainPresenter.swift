//
//  MainPresenter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    var weatherData: Weather? { get }
}

class MainPresenter {
    
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    
    private let dataStorage: DataStorage
    
    var weatherData: Weather?
    
    init() {
        self.dataStorage = DataStorage.shared
    }
}

extension MainPresenter {
    
    func getDataFromStorage() {
        weatherData = dataStorage.currentWeatherData?.data?.first
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func viewDidLoad() {
        getDataFromStorage()
        view?.updateData()
    }
}
