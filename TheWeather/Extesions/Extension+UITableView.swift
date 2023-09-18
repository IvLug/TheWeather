//
//  Extension+UITableView.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }

    func dequeueCell<T: UITableViewCell>(at indexPath: IndexPath, doError: Bool = false) -> T {
        let id = String(describing: T.self)
        let temp = dequeueReusableCell(withIdentifier: id, for: indexPath) as? T
        guard let cell = temp else {
            if doError { fatalError("Can't dequeue cell") }
            return T()
        }
        return cell
    }
}
