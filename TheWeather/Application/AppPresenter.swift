//
//  AppPresenter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 25.05.2023.
//

import Foundation

protocol ApplicationPresenterProtocol: AnyObject {
    func reloadData()
}

class ApplicationPresenter {
    
    var callBack: EmptyClosure?
    
    var router: AppRouterProtocol?
    
    static let shared: ApplicationPresenter = {
        ApplicationPresenter()
    }()
        
    private let locationService = LocationService.shared
    private let dataStorage = DataStorage.shared
    private let dataLouder = DataLouderService()
    
    var isUpdate = false
    
    private init() {
        dataLouder.delegate = self
        configure()
    }
    
    private func configure() {
        locationService.isLoadLocate = { [weak self] isLocate in
            guard let self = self else { return }
            DispatchQueue.global().async {
                self.dataLouder.loadData(self.isUpdate)
            }
        }
    }
}

extension ApplicationPresenter: ApplicationPresenterProtocol {
    
    func reloadData() {
        locationService.updateLocate()
    }
}

extension ApplicationPresenter: DataLouderServiceDelegate {
    
    func dataDidLoad() {
        if isUpdate {
            dataStorage.updatedData()
        } else {
            dataStorage.saveAllDate()
            callBack?()
        }
    }
}

enum ProcessingDataType {
    case coreData
    case api
    case update
}

extension ApplicationPresenter {
    
    /// 1) processingData loaded data
    /// 2) load Data from Cashe if needed
    func processingData(type: ProcessingDataType) {
        let weather = dataStorage.currentWeatherData
        
        guard weather == nil else {
            dataDidLoad()
            return
        }
         
        switch type {
        case .coreData:
            processingError(errorType: .apiDataEmpty)
        case .api:
            loadDataFromCashe()
        case .update:
            dataStorage.updatedData()
        }
    }
    
    func processingError(errorType: ErrorType) {
        DispatchQueue.main.async {
            self.router?.showError(errorType: errorType)
        }
    }
    
    private func loadDataFromCashe() {
        dataStorage.fetchAllData { [weak self] in
            guard let self = self else { return }
            self.processingData(type: .coreData)
        }
    }
}
