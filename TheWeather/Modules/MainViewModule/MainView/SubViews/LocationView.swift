//
//  LocationView.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit

final class LocationView: UIView {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pin")
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        view.text = "Moscow"
        view.textColor = .white
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.text = "May 24, Wed, 11:24 AM"
        view.textColor = .white
        return view
    }()
    
    private lazy var deviderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        backgroundColor = .brandTintColorGray.withAlphaComponent(0.4)
        layer.cornerRadius = 16
    }
    
    private func addSubViews() {
        addSubview(imageView)
        addSubview(cityLabel)
        addSubview(dateLabel)
        addSubview(deviderView)
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(16)
            $0.width.height.equalTo(36)
        }
        
        cityLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.left.equalTo(imageView.snp.right).offset(8)
            $0.centerY.equalTo(imageView)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(6)
            $0.left.right.bottom.equalToSuperview().inset(16)
        }
        
        deviderView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(12)
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview()
        }
    }
}

extension LocationView {
    func setData() {
        
    }
}
