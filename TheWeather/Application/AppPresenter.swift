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
        
        locationService.isUpdateLocate = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.global(qos: .userInitiated).async {
                self.dataLouder.loadData(isUpdate: true) {
                    self.dataStorage.updatedData()
                }
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
        callBack?()
    }
}
