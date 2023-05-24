//
//  CustomTabBar.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit
import SnapKit

protocol TabBarItemViewProtocol: AnyObject {
    func tabBarItemViewDidTouched(model: TabBarItem)
}

final class CustomTabBar: UIView {
    
    var items = [TabBarItem]() {
        didSet { reloadData() }
    }
    
    var itemViews = [BaseTabbarItem]()
    weak var delegate: TabBarItemViewProtocol?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var button: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(butonTouched(button:)), for: .touchUpInside)
        view.backgroundColor = .brandOrange
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubViews()
        setConstraints()
        backgroundColor = .brandLightGray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.layer.cornerRadius = button.bounds.width / 2
        button.addShadow(color: .black, shadowOffset: CGSize(width: 2, height: 2))
    }
    
    private func addSubViews() {
        addSubview(stackView)
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
    }
}

extension CustomTabBar {
    
    private func reloadData() {
        itemViews.forEach({ $0.removeFromSuperview() })
        itemViews.removeAll()
        
        for item in items {
            processedTabbarItemType(item: item)
        }
    }
    
    private func processedTabbarItemType(item: TabBarItem) {
        
        var itemView: BaseTabbarItem
        
        switch item.index {
        case .location:
            itemView = BaseTabbarItem()
            addSubview(button)
            button.snp.makeConstraints {
                $0.width.height.equalTo(80)
                $0.centerY.centerX.equalToSuperview()
            }
            button.setImage(item.image, for: .normal)
        default:
            itemView = TabbarItem(model: item)
            itemView.delegate = self
        }
        
        stackView.addArrangedSubview(itemView)
        itemViews.append(itemView)
    }
    
    @objc func butonTouched(button: UIButton) {
        guard let model = items.first(where: { $0.index == .location }) else { return }
        
        button.rotate(repeatCount: 1, duration: 0.3)
        UIView.animate(withDuration: 0.3,
                       animations: {
            self.button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }, completion: { _ in
            UIView.animate(withDuration: 0.6) {
                self.button.transform = CGAffineTransform.identity
            }
        })
        delegate?.tabBarItemViewDidTouched(model: model)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        
        print(self.button.frame.contains(point))
        return self.button.frame.contains(point) ? self.button : super.hitTest(point, with: event)
    }
}

extension CustomTabBar: TabBarItemViewProtocol {
    
    func tabBarItemViewDidTouched(model: TabBarItem) {
        
        itemViews.forEach { view in
            if view.model?.index == model.index {
                view.shouldBeSelected = true
            } else {
                view.shouldBeSelected = false
            }
            view.setSelected()
        }
        
        delegate?.tabBarItemViewDidTouched(model: model)
    }
}
