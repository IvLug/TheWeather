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
                self.dataLouder.loadData()
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
        isUpdate ? dataStorage.updatedData() : callBack?()
        isUpdate = true
    }
}
