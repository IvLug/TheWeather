//
//  BaseTabbarItem.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit
import SnapKit

class BaseTabbarItem: UIView {
    weak var delegate: TabBarItemViewProtocol?
    var model: TabBarItem?
    var shouldBeSelected: Bool = false

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        return label
    }()

    func setSelected() {
        guard let model = self.model else { return }
        if shouldBeSelected {
            UIView.animate(withDuration: 0.3,
                           animations: {
                self.imageView.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            })
            title.textColor = model.selectedTintColor
            imageView.image = model.image
        } else {
            UIView.animate(withDuration: 0.3,
                           animations: {
                self.imageView.transform = .identity
            })
            title.textColor = model.unselectedTintColor
            imageView.image = model.image?.template
        }
    }
}
