//
//  WeatherNetworkRouter.swift
//  TheWeather
//
//  Created by Иван Луганцов on 25.05.2023.
//

import Foundation
import Alamofire

enum WeatherNetworkRouter: APIRouter {
    
    case currentWeather(cityName: String)
    case dailyWeather(cityName: String)
    
    var method: HTTPMethod {
        switch self {
        case .currentWeather, .dailyWeather:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        return headers
    }
    
    var parameters: Parameters? {
        var params: Parameters = [:]
        switch self {
        case .currentWeather(let cityName):
            params["city"] = cityName
            params["key"] = Constants.apiKey
        case .dailyWeather(cityName: let cityName):
            params["city"] = cityName
            params["key"] = Constants.apiKey
        }
        return params
    }
    
    var servicePath: String {
        return Constants.versionAPI
    }
    
    var body: Data? {
        return nil
    }
    
    var path: String {
        var path = ""
        switch self {
        case .currentWeather:
            path = "/current"
        case .dailyWeather:
            path = "/forecast/daily"
        }
        return Constants.baseURL + servicePath + path
    }
}
