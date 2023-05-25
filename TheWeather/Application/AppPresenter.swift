//
//  AppPresenter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 25.05.2023.
//

import Foundation

class ApplicationPresenter {
    
    var callBack: EmptyClosure?
    
    private let locationService = LocationService.shared
    private let dataStorage = DataStorage.shared
    private let dataLouder = DataLouderService()
    
    init() {
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

extension ApplicationPresenter: DataLouderServiceDelegate {
    
    func dataDidLoad() {
        callBack?()
    }
}
