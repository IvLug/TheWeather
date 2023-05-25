//
//  ErrorModel.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation

struct ErrorModel: Codable, Error {
    let httpStatus, message, errorCode: String?
    let httpStatusCode: Int?
    let uri: String?
}
