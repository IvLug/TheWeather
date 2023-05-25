//
//  Extension+String.swift
//  TheWeather
//
//  Created by Иван Луганцов on 25.05.2023.
//

import Foundation

extension String {
    func numberOfHours() -> Int {
        let components: Array = self.components(separatedBy: ":")
        let hours = Int(components.first ?? "") ?? 0
        return hours
    }
}
