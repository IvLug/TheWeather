//
//  TabbarItem.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit

class TabbarItem: BaseTabbarItem {
    
    private lazy var button: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(butonTouched(button:)), for: .touchUpInside)
        return view
    }()
    
    convenience init(model: TabBarItem) {
        self.init(frame: .zero)
        self.model = model
        title.text = model.title
        configure()
        shouldBeSelected = model.shouldBeSelected
        setSelected()
        button.tintColor = model.unselectedTintColor
    }
    
    private func configure() {
        addSubViews()
        setConstraints()
        backgroundColor = .brandLightGray
    }
    
    private func addSubViews() {
        addSubview(button)
        button.addSubview(imageView)
        button.addSubview(title)
    }
    
    private func setConstraints() {
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(title.snp.top)
            $0.top.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.height.equalTo(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func butonTouched(button: UIButton) {
        model?.shouldBeSelected = true
        guard let model = self.model else { return }
        delegate?.tabBarItemViewDidTouched(model: model)
    }
}
