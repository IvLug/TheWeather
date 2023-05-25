//
//  TabBarViewController.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit
import SnapKit

class TabBarViewController: UIViewController {
    
    private weak var currentController: UIViewController?
    
    weak var presenter: ApplicationPresenterProtocol?
    
    var items = [TabBarItem]()
    
    private lazy var customTabBar: CustomTabBar = {
        let tabBar = CustomTabBar()
        tabBar.delegate = self
        return tabBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
        customTabBar.addShadow(color: .black, shadowOffset: CGSize(width: 2, height: 2))
    }
    
    private func configure() {
        addSubViews()
        setupTabBarItems()
        
        if let controller = customTabBar.items.first?.controller {
            open(controller)
        }
    }
    
    private func addSubViews() {
        view.addSubview(customTabBar)
    }

    private func setConstraints() {
        customTabBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
}

extension TabBarViewController {
    
    func setupTabBarItems() {
        
        let selectedColor = UIColor.brandOrange
        let unselectedImageColor = UIColor.lightGray
        
        let mainModule = MainScreenAssembly.assembly(navigation: true).view
        let forecastModule = ForecastScreenAssembly.assembly(navigation: true).view
        
        let mainModel = TabBarItem(index: .main,
                                   title: "Main",
                                   image: UIImage(named: "1d"),
                                   selectedTintColor: selectedColor,
                                   unselectedTintColor: unselectedImageColor,
                                   shouldBeSelected: true,
                                   controller: mainModule)
        
        let forecast = TabBarItem(index: .forecast,
                                  title: "Forecast",
                                  image: UIImage(named: "1n"),
                                  selectedTintColor: selectedColor,
                                  unselectedTintColor: unselectedImageColor,
                                  shouldBeSelected: false,
                                  controller: forecastModule)
        
        let location = TabBarItem(index: .location,
                                  title: "",
                                  image: UIImage(named: "map-pin"),
                                  selectedTintColor: selectedColor,
                                  unselectedTintColor: unselectedImageColor,
                                  shouldBeSelected: true,
                                  controller: mainModule)
        
        items.append(contentsOf: [
            mainModel,
            location,
            forecast
        ])
        customTabBar.items = items
    }
}

extension TabBarViewController: TabBarItemViewProtocol {
    
    func tabBarItemViewDidTouched(model: TabBarItem) {
        
        switch model.index {
        case .location:
            guard let item = items.first(where: { $0.index == .main }) else { return }
            open(item.controller)
            presenter?.reloadData()
        default:
            guard let item = items.first(where: { $0.index == model.index }) else { return }
            open(item.controller)
        }
    }
}

extension TabBarViewController {
    
    func open(_ controller: UIViewController) {
        if currentController == controller, currentController is UINavigationController {
            _ = (currentController as? UINavigationController)?.popToRootViewController(animated: true)
            return
        }
        
        currentController?.view.removeFromSuperview()
        currentController?.removeFromParent()
        currentController = controller
        
        addChild(controller)
        view.addSubview(controller.view)
        view.sendSubviewToBack(controller.view)
        
        currentController?.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight,
                                            .flexibleTopMargin, .flexibleBottomMargin,
                                            .flexibleLeftMargin, .flexibleRightMargin]
    }
}
