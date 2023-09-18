//
//  MainRouter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

protocol MainRouterProtocol: AnyObject {
    func showError(errorType: ErrorType)
}

final class MainRouter {

    weak var view: MainViewProtocol?
}

extension MainRouter: MainRouterProtocol {

    func showError(errorType: ErrorType) {
        view?.showAlert(
            title: errorType.error.localizedFailureReason,
            message: errorType.error.localizedDescription,
            okAction: { _ in })
    }
}
