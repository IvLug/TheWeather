//
//  DescriptionWeatherView.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit

enum DescriptionWeatherType: CaseIterable {
    case sunset
    case wind
    case rein
    
    var imageName: String {
        switch self {
        case .sunset:
            return "sunrise.fill"
        case .wind:
            return "wind"
        case .rein:
            return "umbrella.fill"
        }
    }
    
    var mocText: String {
        switch self {
        case .sunset:
            return "00:00"
        case .wind:
            return "0.00"
        case .rein:
            return "100"
        }
    }
}

final class DescriptionWeatherView: UIView {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun.max")
        view.tintColor = .white
        return view
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        view.text = "0.0°"
        view.textColor = .white
        return view
    }()
    
    private lazy var skyInfoLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.text = "Clear sky"
        view.textColor = .white
        return view
    }()
    
    private lazy var stack: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var deviderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var stackLabels = [DescriptionWeatherType : UILabel]()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setStackData()
        addSubViews()
        setConstraints()
        backgroundColor = .brandTintColorGray.withAlphaComponent(0.4)
        layer.cornerRadius = 16
    }
    
    private func addSubViews() {
        addSubview(stack)
        addSubview(conteinerView)
        
        conteinerView.addSubview(imageView)
        conteinerView.addSubview(tempLabel)
        conteinerView.addSubview(skyInfoLabel)
        addSubview(deviderView)
    }
    
    private func setConstraints() {
        stack.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview().inset(16)
        }
        
        conteinerView.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(16)
            $0.right.equalTo(stack.snp.left)
        }
        
        imageView.snp.makeConstraints {
            $0.top.right.equalToSuperview()
            $0.width.height.equalTo(30)
            $0.centerY.equalTo(tempLabel)
        }
        
        tempLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalTo(imageView.snp.left).offset(2)
        }
        
        skyInfoLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(6)
            $0.left.right.bottom.equalToSuperview()
        }
        
        deviderView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(12)
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setStackData() {
        let cases = DescriptionWeatherType.allCases
        
        cases.forEach { type in
            let containerView = UIView()
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: type.imageName)
            imageView.tintColor = .white
            imageView.contentMode = .scaleAspectFit
            containerView.addSubview(imageView)
            imageView.snp.makeConstraints {
                $0.top.left.right.equalToSuperview()
                $0.height.equalTo(36)
            }
            
            let label = UILabel()
            label.text = type.mocText
            label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
            label.textAlignment = .center
            label.textColor = .white
            
            containerView.addSubview(label)
            label.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(2)
                $0.left.right.bottom.equalToSuperview()
            }
           
            stack.addArrangedSubview(containerView)
            stackLabels[type] = label
            containerView.snp.makeConstraints {
                $0.width.equalTo(50)
            }
        }
    }
}

extension DescriptionWeatherView {
    func setData(model: Weather) {
        tempLabel.text = "\(model.temp ?? 0)°"
        skyInfoLabel.text = model.weather?.description
        
        stackLabels.forEach { type, label in
            switch type {
            case .sunset:
                label.text = model.sunset
            case .wind:
                label.text = "\(model.windSpeed ?? 0) m/s"
            case .rein:
                label.text = "\(model.clouds ?? 0) %"
            }
        }
    }
}

