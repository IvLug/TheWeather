//
//  TempView.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit

final class TempView: UIView {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun.max")
        view.tintColor = .white
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        view.text = "19.1°"
        view.textColor = .white
        return view
    }()
    
    private lazy var skyInfoLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.text = "Clear sky"
        view.textColor = .white
        view.textAlignment = .center
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
        addSubview(tempLabel)
        addSubview(skyInfoLabel)
        addSubview(deviderView)
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(12)
            $0.width.height.equalTo(30)
            $0.centerY.equalTo(tempLabel)
        }
        
        tempLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.right.equalTo(imageView.snp.left).offset(2)
        }
        
        skyInfoLabel.snp.makeConstraints {
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

extension TempView {
    func setData() {
        
    }
}
