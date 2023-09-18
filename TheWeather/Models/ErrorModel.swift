//
//  ErrorModel.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation

enum ErrorType {
    case apiDataEmpty
    case coreDataEmpty
    case allEmpty
    case locationError
    case cityFoundError

    var error: NSError {

        switch self {
        case .apiDataEmpty:
            return NSError.error(title: "Oops",
                                 message: "Failed to load data from server. Data may not be accurate.")
        case .coreDataEmpty:
            return NSError.error(title: "Oops", message: "Failed to load local data.")
        case .allEmpty:
            return NSError.error(title: "Oops", message: "Failed to load data.")
        case .locationError:
            return NSError.error(title: "Oops", message: "Failed to set your location.")
        case .cityFoundError:
            return NSError.error(title: "Oops", message: "city not found.")
        }
    }

    var succeseButtonTitle: String {
        switch self {
        case .locationError:
            return "Settings"
        default: return "Ok"
        }
    }

    var cancelButtonTitle: String {
        return "Cancel"
    }
}
