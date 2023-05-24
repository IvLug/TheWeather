//
//  TabbarModel.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit

enum TabBarItemIndex: Int {
    case main
    case forecast
    case location
    case none
}

struct TabBarItem {
    var shouldBeSelected: Bool = true

    var index: TabBarItemIndex
    var title: String
    var image: UIImage?

    var selectedTintColor: UIColor
    var unselectedTintColor: UIColor

    var controller: UIViewController

    init(index: TabBarItemIndex,
         title: String,
         image: UIImage?,
         selectedTintColor: UIColor,
         unselectedTintColor: UIColor,
         shouldBeSelected: Bool = false,
         controller: UIViewController) {
        self.index = index
        self.title = title
        self.image = image

        self.shouldBeSelected = shouldBeSelected

        self.selectedTintColor = selectedTintColor
        self.unselectedTintColor = unselectedTintColor

        self.controller = controller
    }
}
