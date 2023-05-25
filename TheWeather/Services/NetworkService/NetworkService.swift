//
//  NetworkService.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import Foundation
import Alamofire

final class NetworkService: RequestInterceptor {
    
    static let shared: NetworkService = {
        let instance = NetworkService()
        return instance
    }()
    
    private init() {}
    
    @discardableResult
    public func performRequest<T:Decodable>(route: APIRouter,
                                            completion: @escaping (Result<T, AFError>) -> Void) -> DataRequest? {
        if route.method == .get {
            guard let url = try? route.path.asURL() else {
                print("LOG: - Can't build Request with path \(route.path)")
                return nil
            }
            let eng = URLEncoding(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
            return AF.request(url,
                              method: route.method,
                              parameters: route.parameters,
                              encoding: eng,
                              headers: route.headers,
                              interceptor: self)
            .validate()
            .responseDecodable { (response: DataResponse<T, AFError>) in
                completion(response.result)
            }
        } else {
            guard let request = route.uploadRequest else {
                print("LOG: - Can't build Request with path \(route.path)")
                return nil
            }
            return AF.request(request).validate().responseDecodable { (response: DataResponse<T, AFError>) in
                completion(response.result)
            }
        }
    }
}
