//
//  ModuleAssembley.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

protocol ModuleAssembly {
    static func assembly(navigation: Bool) -> Self
    var view: UIViewController { get }
}
